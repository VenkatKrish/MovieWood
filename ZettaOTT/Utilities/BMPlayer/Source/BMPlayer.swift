//
//  BMPlayer.swift
//  Pods
//
//  Created by BrikerMan on 16/4/28.
//
//

import UIKit
import MediaPlayer

/// BMPlayerDelegate to obserbe player state
public protocol BMPlayerDelegate : AnyObject {
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState)
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval)
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime : TimeInterval, totalTime: TimeInterval)
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool)
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool)
}

/**
 internal enum to check the pan direction
 
 - horizontal: horizontal
 - vertical:   vertical
 */
enum BMPanDirection: Int {
    case horizontal = 0
    case vertical   = 1
}

open class BMPlayer: UIView {
    fileprivate weak var parentView : UIView?
    fileprivate var viewFrame = CGRect()
    open fileprivate(set) var isFullScreenVal : Bool = false
    open fileprivate(set) var isSubTitleVal : Bool = false

    open weak var delegate: BMPlayerDelegate?
    
    open var backBlock:((Bool) -> Void)?
    
    /// Gesture to change volume / brightness
    open var panGesture: UIPanGestureRecognizer!
    
    /// AVLayerVideoGravityType
    open var videoGravity = AVLayerVideoGravity.resizeAspectFill {
        didSet {
            self.playerLayer?.videoGravity = videoGravity
        }
    }
    
    open var isPlaying: Bool {
        get {
            return playerLayer?.isPlaying ?? false
        }
    }
    
    //Closure fired when play time changed
    open var playTimeDidChange:((TimeInterval, TimeInterval) -> Void)?

    //Closure fired when play state chaged
    @available(*, deprecated, message: "Use newer `isPlayingStateChanged`")
    open var playStateDidChange:((Bool) -> Void)?

    open var playOrientChanged:((Bool) -> Void)?

    open var isPlayingStateChanged:((Bool) -> Void)?

    open var playStateChanged:((BMPlayerState) -> Void)?
    
    open var avPlayer: AVPlayer? {
        return playerLayer?.player
    }
    
    open var playerLayer: BMPlayerLayerView?
    
    fileprivate var resource: BMPlayerResource!
    
    fileprivate var currentDefinition = 0
    
    var controlView: BMPlayerControlView!
    
    fileprivate var customControlView: BMPlayerControlView?
    
     
    
    /// Sliding direction
    fileprivate var panDirection = BMPanDirection.horizontal
    
    /// Volume Sliding Pole
    fileprivate var volumeViewSlider: UISlider!
    
    fileprivate let BMPlayerAnimationTimeInterval: Double             = 4.0
    fileprivate let BMPlayerControlBarAutoFadeOutTimeInterval: Double = 0.5
    
    /// Used to save time status
    fileprivate var sumTime         : TimeInterval = 0
    fileprivate var totalDuration   : TimeInterval = 0
    public var currentPosition : TimeInterval = 0
    fileprivate var shouldSeekTo    : TimeInterval = 0
    
    fileprivate var isURLSet        = false
    fileprivate var isSliderSliding = false
    fileprivate var isPauseByUser   = false
    fileprivate var isVolume        = false
    fileprivate var isMaskShowing   = false
    fileprivate var isSlowed        = false
    fileprivate var isMirrored      = false
    fileprivate var isPlayToTheEnd  = false
    //Video aspect ratio
    fileprivate var aspectRatio: BMPlayerAspectRatio = .default
    
    //Cache is playing result to improve callback performance
    fileprivate var isPlayingCache: Bool? = nil
    
    // MARK: - Public functions
    
    /**
     Play
     
     - parameter resource:        media resource
     - parameter definitionIndex: starting definition index, default start with the first definition
     */
    open func setVideo(resource: BMPlayerResource, definitionIndex: Int = 0) {
        isURLSet = false
        self.resource = resource
        
        currentDefinition = definitionIndex
        controlView.prepareUI(for: resource, selectedIndex: definitionIndex)
        
        if BMPlayerConf.shouldAutoPlay {
            isURLSet = true
            let asset = resource.definitions[definitionIndex]
            playerLayer?.playAsset(asset: asset.avURLAsset)
        } else {
            controlView.showCover(url: resource.cover)
            controlView.hideLoader()
        }
    }
    
    /**
     auto start playing, call at viewWillAppear, See more at pause
     */
    open func autoPlay() {
        if !isPauseByUser && isURLSet && !isPlayToTheEnd {
            play()
        }
    }
    
    /**
     Play
     */
    open func play() {
        guard resource != nil else { return }
        
        if !isURLSet {
            let asset = resource.definitions[currentDefinition]
            playerLayer?.playAsset(asset: asset.avURLAsset)
            controlView.hideCoverImageView()
            isURLSet = true
        }
        
        panGesture.isEnabled = true
        playerLayer?.play()
        isPauseByUser = false
    }
    
    /**
     Pause
     
     - parameter allow: should allow to response `autoPlay` function
     */
    open func pause(allowAutoPlay allow: Bool = false) {
        playerLayer?.pause()
        isPauseByUser = !allow
    }
    
    /**
     seek
     
     - parameter to: target time
     */
    open func seek(_ to:TimeInterval, completion: (()->Void)? = nil) {
        playerLayer?.seek(to: to, completion: completion)
    }
    
    /**
     update UI to fullScreen
     */
    open func updateUI(_ isFullScreen: Bool) {
        controlView.updateUI(isFullScreen)
    }
    
    /**
     increade volume with step, default step 0.1
     
     - parameter step: step
     */
    open func addVolume(step: Float = 0.1) {
        self.volumeViewSlider.value += step
    }
    
    /**
     decreace volume with step, default step 0.1
     
     - parameter step: step
     */
    open func reduceVolume(step: Float = 0.1) {
        self.volumeViewSlider.value -= step
    }
    
    /**
     prepare to dealloc player, call at View or Controllers deinit funciton.
     */
    open func prepareToDealloc() {
        playerLayer?.prepareToDeinit()
        controlView.prepareToDealloc()
    }
    
    /**
     If you want to create BMPlayer with custom control in storyboard.
     create a subclass and override this method.
     
     - return: costom control which you want to use
     */
    open func storyBoardCustomControl() -> BMPlayerControlView? {
        return nil
    }
    
    // MARK: - Action Response
    
    @objc fileprivate func panDirection(_ pan: UIPanGestureRecognizer) {
        // ?????????view???Pan??????????????????????????????????????????
        let locationPoint = pan.location(in: self)
        
        // ??????????????????????????????????????????
        // ????????????????????????????????????????????????????????????point
        let velocityPoint = pan.velocity(in: self)
        
        // ???????????????????????????????????????
        switch pan.state {
        case UIGestureRecognizer.State.began:
            // ???????????????????????????????????????
            let x = abs(velocityPoint.x)
            let y = abs(velocityPoint.y)
            
            if x > y {
                if BMPlayerConf.enablePlaytimeGestures {
                    self.panDirection = BMPanDirection.horizontal
                    
                    // ???sumTime??????
                    if let player = playerLayer?.player {
                        let time = player.currentTime()
                        self.sumTime = TimeInterval(time.value) / TimeInterval(time.timescale)
                    }
                }
            } else {
                self.panDirection = BMPanDirection.vertical
                if locationPoint.x > self.bounds.size.width / 2 {
                    self.isVolume = true
                } else {
                    self.isVolume = false
                }
            }
            
        case UIGestureRecognizer.State.changed:
            switch self.panDirection {
            case BMPanDirection.horizontal:
                self.horizontalMoved(velocityPoint.x)
            case BMPanDirection.vertical:
                self.verticalMoved(velocityPoint.y)
            }
            
        case UIGestureRecognizer.State.ended:
            switch (self.panDirection) {
            case BMPanDirection.horizontal:
                controlView.hideSeekToView()
                isSliderSliding = false
                if isPlayToTheEnd {
                    isPlayToTheEnd = false
                    seek(self.sumTime, completion: {[weak self] in
                        self?.play()
                    })
                } else {
                    seek(self.sumTime, completion: {[weak self] in
                        self?.autoPlay()
                    })
                }
                // ???sumTime??????????????????????????????
                self.sumTime = 0.0
                
            case BMPanDirection.vertical:
                self.isVolume = false
            }
        default:
            break
        }
    }
    
    fileprivate func verticalMoved(_ value: CGFloat) {
        if BMPlayerConf.enableVolumeGestures && self.isVolume{
            self.volumeViewSlider.value -= Float(value / 10000)
        }
        else if BMPlayerConf.enableBrightnessGestures && !self.isVolume{
            UIScreen.main.brightness -= value / 10000
        }
    }
    
    fileprivate func horizontalMoved(_ value: CGFloat) {
        guard BMPlayerConf.enablePlaytimeGestures else { return }
        
        isSliderSliding = true
        if let playerItem = playerLayer?.playerItem {
            // ??????????????????????????????????????????????????????????????????????????????????????????
            self.sumTime = self.sumTime + TimeInterval(value) / 100.0 * (TimeInterval(self.totalDuration)/400)
            
            let totalTime = playerItem.duration
            
            // ????????????NAN
            if totalTime.timescale == 0 { return }
            
            let totalDuration = TimeInterval(totalTime.value) / TimeInterval(totalTime.timescale)
            if (self.sumTime >= totalDuration) { self.sumTime = totalDuration }
            if (self.sumTime <= 0) { self.sumTime = 0 }
            
            controlView.showSeekToView(to: sumTime, total: totalDuration, isAdd: value > 0)
        }
    }
    
    func getWindow()-> UIWindow?{
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return nil
          }
          return sceneDelegate.window
    }
    
    // MARK: - ????????????
    deinit {
        playerLayer?.pause()
        playerLayer?.prepareToDeinit()
        NotificationCenter.default.removeObserver(self, name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let customControlView = storyBoardCustomControl() {
            self.customControlView = customControlView
        }
        initUI()
        self.addDeviceOrientationNotifications()
        configureVolume()
        preparePlayer()
    }
    
    @available(*, deprecated:3.0, message:"Use newer init(customControlView:_)")
    public convenience init(customControllView: BMPlayerControlView?) {
        self.init(customControlView: customControllView)
    }
    
    public init(customControlView: BMPlayerControlView?) {
        super.init(frame:CGRect.zero)
        self.customControlView = customControlView
        initUI()
        self.addDeviceOrientationNotifications()
        configureVolume()
        preparePlayer()
    }
    
    public convenience init() {
        self.init(customControlView:nil)
    }
    
    // MARK: - ?????????
    fileprivate func initUI() {
        self.backgroundColor = UIColor.black
        
        if let customView = customControlView {
            controlView = customView
        } else {
            controlView = BMPlayerControlView()
        }
        
        addSubview(controlView)
        controlView.updateUI(isFullScreenVal)
        controlView.delegate = self
        controlView.player   = self
        controlView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panDirection(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    internal func addDeviceOrientationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationWillChange(_:)), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    
    
    @objc internal func deviceOrientationWillChange(_ sender: Notification) {
        let orientation = UIDevice.current.orientation
        var  statusBarOrientation:UIInterfaceOrientation!
        if #available(iOS 13.0, *) {
            statusBarOrientation = self.getWindow()?.windowScene?.interfaceOrientation
        }else{
            statusBarOrientation = UIApplication.shared.statusBarOrientation
        }
        if statusBarOrientation == .portrait{
            if superview != nil {
                parentView = (superview)!
                viewFrame = frame
            }
        }
        switch orientation {
        case .unknown:
            break
        case .faceDown:
            break
        case .faceUp:
            break
        case .landscapeLeft:
            onDeviceOrientation(true, orientation: .landscapeLeft)
        case .landscapeRight:
            onDeviceOrientation(true, orientation: .landscapeRight)
        case .portrait:
            onDeviceOrientation(false, orientation: .portrait)
        case .portraitUpsideDown:
            onDeviceOrientation(false, orientation: .portraitUpsideDown)
        default:
            onDeviceOrientation(false, orientation: .portraitUpsideDown)
        }
    }
    
    internal func onDeviceOrientation(_ fullScreen: Bool, orientation: UIInterfaceOrientation) {
        var  statusBarOrientation:UIInterfaceOrientation!
        if #available(iOS 13.0, *) {
            statusBarOrientation = self.getWindow()?.windowScene?.interfaceOrientation
        }else{
            statusBarOrientation = UIApplication.shared.statusBarOrientation
        }
       
        if orientation == statusBarOrientation {
            if orientation == .landscapeLeft || orientation == .landscapeLeft {
                if let window = self.getWindow(){
                    let rectInWindow = convert(bounds, to: window)
                    removeFromSuperview()
                    frame = rectInWindow
                    window.addSubview(self)
                    self.snp.remakeConstraints({ [weak self] (make) in
                        guard let strongSelf = self else { return }
                        make.width.equalTo(strongSelf.superview!.bounds.width)
                        make.height.equalTo(strongSelf.superview!.bounds.height)
                    })
                }
            }
        } else {
            if orientation == .landscapeLeft || orientation == .landscapeRight {
                if let window = self.getWindow(){
                    let rectInWindow = convert(bounds, to: window)
                    removeFromSuperview()
                    frame = rectInWindow
                    window.addSubview(self)
                    self.snp.remakeConstraints({ [weak self] (make) in
                        guard let strongSelf = self else { return }
                        make.width.equalTo(strongSelf.superview!.bounds.height)
                        make.height.equalTo(strongSelf.superview!.bounds.width)
                    })
                }
                
            } else if orientation == .portrait{
                if parentView == nil { return }
                removeFromSuperview()
                parentView!.addSubview(self)
                let frame = parentView!.convert(viewFrame, to: self.getWindow())
                self.snp.remakeConstraints({ (make) in
                    make.centerX.equalTo(viewFrame.midX)
                    make.centerY.equalTo(viewFrame.midY)
                    make.width.equalTo(frame.width)
                    make.height.equalTo(frame.height)
                })
                viewFrame = CGRect()
                parentView = nil
            }
        }
        isFullScreenVal = fullScreen
        self.updateUI(isFullScreenVal)
        delegate?.bmPlayer(player: self, playerOrientChanged: isFullScreenVal)
        playOrientChanged?(isFullScreenVal)
        
//        delegate?.vgPlayerView(self, willFullscreen: isFullScreen)
    }
    
    fileprivate func configureVolume() {
        let volumeView = MPVolumeView()
        for view in volumeView.subviews {
            if let slider = view as? UISlider {
                self.volumeViewSlider = slider
            }
        }
    }
    
    fileprivate func preparePlayer() {
        playerLayer = BMPlayerLayerView()
        playerLayer!.videoGravity = videoGravity
        insertSubview(playerLayer!, at: 0)
        playerLayer!.snp.makeConstraints { [weak self](make) in
          guard let `self` = self else { return }
          make.edges.equalTo(self)
        }
        playerLayer!.delegate = self
        controlView.showLoader()
        self.layoutIfNeeded()
    }
}

extension BMPlayer: BMPlayerLayerViewDelegate {
    public func bmPlayer(player: BMPlayerLayerView, playerIsPlaying playing: Bool) {
        controlView.playStateDidChange(isPlaying: playing)
        delegate?.bmPlayer(player: self, playerIsPlaying: playing)
        playStateDidChange?(player.isPlaying)
        isPlayingStateChanged?(player.isPlaying)
    }
    
    public func bmPlayer(player: BMPlayerLayerView, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        BMPlayerManager.shared.log("loadedTimeDidChange - \(loadedDuration) - \(totalDuration)")
        controlView.loadedTimeDidChange(loadedDuration: loadedDuration, totalDuration: totalDuration)
        delegate?.bmPlayer(player: self, loadedTimeDidChange: loadedDuration, totalDuration: totalDuration)
        controlView.totalDuration = totalDuration
        self.totalDuration = totalDuration
    }
    
    public func bmPlayer(player: BMPlayerLayerView, playerStateDidChange state: BMPlayerState) {
        BMPlayerManager.shared.log("playerStateDidChange - \(state)")
        
        controlView.playerStateDidChange(state: state)
        switch state {
        case .readyToPlay:
            if !isPauseByUser {
                play()
            }
            if shouldSeekTo != 0 {
                seek(shouldSeekTo, completion: {[weak self] in
                  guard let `self` = self else { return }
                  if !self.isPauseByUser {
                      self.play()
                  } else {
                      self.pause()
                  }
                })
                shouldSeekTo = 0
            }
            
        case .bufferFinished:
            autoPlay()
            
        case .playedToTheEnd:
            isPlayToTheEnd = true
            
        default:
            break
        }
        panGesture.isEnabled = state != .playedToTheEnd
        delegate?.bmPlayer(player: self, playerStateDidChange: state)
        playStateChanged?(state)
    }
    
    public func bmPlayer(player: BMPlayerLayerView, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        BMPlayerManager.shared.log("playTimeDidChange - \(currentTime) - \(totalTime)")
        delegate?.bmPlayer(player: self, playTimeDidChange: currentTime, totalTime: totalTime)
        self.currentPosition = currentTime
        totalDuration = totalTime
        if isSliderSliding {
            return
        }
        controlView.playTimeDidChange(currentTime: currentTime, totalTime: totalTime)
        controlView.totalDuration = totalDuration
        playTimeDidChange?(currentTime, totalTime)
    }
}

extension BMPlayer: BMPlayerControlViewDelegate {
    open func controlView(controlView: BMPlayerControlView,
                          didChooseDefinition index: Int) {
        shouldSeekTo = currentPosition
        playerLayer?.resetPlayer()
        currentDefinition = index
        playerLayer?.playAsset(asset: resource.definitions[index].avURLAsset)
    }
    
    open func controlView(controlView: BMPlayerControlView,
                          didPressButton button: UIButton) {
        if let action = BMPlayerControlView.ButtonType(rawValue: button.tag) {
            switch action {
            case .back:
                backBlock?(isFullScreenVal)
                if isFullScreenVal {
                    exitFullscreen()
//                    fullScreenButtonPressed()
                } else {
                    playerLayer?.prepareToDeinit()
                }
                
            case .play:
                if button.isSelected {
                    pause()
                } else {
                    if isPlayToTheEnd {
                        seek(0, completion: {[weak self] in
                          self?.play()
                        })
                        controlView.hidePlayToTheEndView()
                        isPlayToTheEnd = false
                    }
                    play()
                }
                
            case .replay:
                isPlayToTheEnd = false
                seek(0)
                play()
                
            case .fullscreen:
                button.isSelected = !button.isSelected
                isFullScreenVal = button.isSelected
                if isFullScreenVal {
                    enterFullscreen()
                } else {
                    exitFullscreen()
                }
                
//                parentView = (self.superview)!
//                viewFrame = self.frame
//                fullScreenButtonPressed()
                
            case .subtitleToggle:
                button.isSelected = !button.isSelected
                isSubTitleVal = button.isSelected
                self.controlView.updateUISubtitle(isSubTitleVal)
            default:
                print("[Error] unhandled Action")
            }
        }
    }
    open func enterFullscreen() {
        let statusBarOrientation = UIApplication.shared.statusBarOrientation
        if statusBarOrientation == .portrait{
            parentView = (self.superview)!
            viewFrame = self.frame
        }
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        UIApplication.shared.statusBarOrientation = .landscapeRight
        UIApplication.shared.setStatusBarHidden(false, with: .fade)
    }
    
    open func exitFullscreen() {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIApplication.shared.statusBarOrientation = .portrait
    }
    open func controlView(controlView: BMPlayerControlView,
                          slider: UISlider,
                          onSliderEvent event: UIControl.Event) {
        switch event {
        case .touchDown:
            playerLayer?.onTimeSliderBegan()
            isSliderSliding = true
            
        case .touchUpInside :
            isSliderSliding = false
            let target = self.totalDuration * Double(slider.value)
            
            if isPlayToTheEnd {
                isPlayToTheEnd = false
                seek(target, completion: {[weak self] in
                  self?.play()
                })
                controlView.hidePlayToTheEndView()
            } else {
                seek(target, completion: {[weak self] in
                  self?.autoPlay()
                })
            }
        default:
            break
        }
    }
    
    open func controlView(controlView: BMPlayerControlView, didChangeVideoAspectRatio: BMPlayerAspectRatio) {
        self.playerLayer?.aspectRatio = self.aspectRatio
    }
    
    open func controlView(controlView: BMPlayerControlView, didChangeVideoPlaybackRate rate: Float) {
        self.playerLayer?.player?.rate = rate
    }
}
