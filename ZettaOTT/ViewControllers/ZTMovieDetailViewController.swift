//
//  ZTMovieDetailViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/11/21.
//

import UIKit
import CarbonKit

struct MyConstraint {
    static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: constraint.firstItem!,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: multiplier,
            constant: constraint.constant)
        
        newConstraint.priority = constraint.priority
        
        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
class ZTMovieDetailViewController: UIViewController {
    
    private weak var displayLink: CADisplayLink?
    private var startTime: TimeInterval?
    private var elapsed: TimeInterval = 0
    private var priorElapsed: TimeInterval = 0
    private var totalElapsed: TimeInterval = 0

    var nextMovieSeasonEpisode:[NextMovieSeasonEpisode] = []
    var movieLinkModel:MovieLinkModel? = nil
    var isLastSeasonVideo : Bool = false
    var movieSeasonId : Int64 = 0
    var readMoreTextLimit:Int64 = 120
    var seasonEpisodeId : Int64 = 0
    var currentDuration : TimeInterval = -1
    var overAllDuration : Double = 0
    var videoPlayerSize : CGFloat = 0.3
    var videoBannerSize : CGFloat = 0.4
    var tryingCount = 0
    var videoUrlVal : URL? = nil
    var zTSeasonVideoListViewController: ZTSeasonVideoListViewController?
    var carbonKitTabs:[String] = []
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var homeCarbonSelectedSegment: UInt = 0
    var movieSeasons: [MovieSeasons]? = []
    @IBOutlet weak var btnMoreReview: UIButton!
    @IBOutlet weak var btnWriteAReview: UIButton!
    @IBOutlet weak var imgVwMovieBanner: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    @IBOutlet weak var collectionGenre: UICollectionView!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var collectionCast: UICollectionView!
    @IBOutlet weak var collectionCrew: UICollectionView!
    var moviewDetails : Movies? = nil
    @IBOutlet weak var stackTeaser: UIStackView!
    @IBOutlet weak var stackGenre: UIStackView!
    @IBOutlet weak var stackReadmore: UIStackView!
    @IBOutlet weak var stackCast: UIStackView!
    @IBOutlet weak var stackCrew: UIStackView!
    @IBOutlet weak var stackSeason: UIStackView!
    @IBOutlet weak var stackRecommended: UIStackView!
    @IBOutlet weak var stackReviews: UIStackView!
    @IBOutlet weak var collectionRecommended: UICollectionView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReviesCount: UILabel!
    @IBOutlet weak var imgVwTeaser: UIImageView!
    @IBOutlet weak var imgVwTrailer: UIImageView!
    @IBOutlet weak var vwTeaser: UIView!
    @IBOutlet weak var vwTrailer: UIView!
    @IBOutlet weak var lblTeaserTitle: UILabel!
    @IBOutlet weak var lblTrailerTitle: UILabel!
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var carbonKitSeasonView: UIView!
    @IBOutlet weak var vwRateThisMoview: UIView!
    @IBOutlet weak var playerView: BMPlayer!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var videoHeightMultiplierHeight: NSLayoutConstraint!
    @IBOutlet weak var tblReviews: ZTContentSizedTableView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var btnBookNow: UIButton!
    @IBOutlet weak var vwExclusive: UIView!
    @IBOutlet weak var lblExclusiveText: UILabel!
    var recommendedMovies : [Movies]? = []
    var moviewReviews : [MovieReviews]? = []
    @IBOutlet weak var lblTblReviewsCount: UILabel!
    var readMoreClicked : Bool = false
    var currentMovieId : Int64 = -1
    var transMovieId : Int64? = -1
    var isDirectEpisodeWatchNow : Bool = true
    var isDirect_Epi_Seek : Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btnBack.isHidden = false
        UIApplication.shared.isIdleTimerDisabled = true
        self.zTSeasonVideoListViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTSeasonVideoListViewController") as? ZTSeasonVideoListViewController
        // Do any additional setup after loading the view.
        self.registerCells()
        AppUtility.lockOrientation(.all)
        NotificationCenter.default.addObserver(self, selector: #selector(videoRefresh(_:)), name: NSNotification.Name(rawValue: SEASON_VIDEO_SELECTION), object: nil)
        self.getMovieDetails()


    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
        AppUtility.lockOrientation(.portrait)
        self.playerView.pause(allowAutoPlay: false)
        if currentDuration != -1{
            self.updateVideoPlayTime(currentTime: self.currentDuration, elapsedTime: self.totalElapsed)
        }
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(SEASON_VIDEO_SELECTION), object: nil)
    }
    func registerCells(){
        self.tblReviews.rowHeight = UITableView.automaticDimension
        self.tblReviews.estimatedRowHeight = 100
        self.tblReviews.isScrollEnabled = false
        self.tblReviews.register(UINib(nibName: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell)
        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell)
       
        self.collectionRecommended.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell)
        
        self.collectionCast.register(UINib(nibName: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell)
        
        self.collectionCrew.register(UINib(nibName: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell)


    }
    func multiplierHeightChange(sizeVal:CGFloat){
        self.videoHeightMultiplierHeight = MyConstraint.changeMultiplier(self.videoHeightMultiplierHeight, multiplier: sizeVal)
    }
    func initialLoad(){
        self.btnBack.isHidden = false
        self.videoPlayerView.isHidden = true
        self.multiplierHeightChange(sizeVal: self.videoBannerSize)
        self.refreshReadmoreUI()
        if let movieInfo = self.moviewDetails{
            self.lblMovieDescription.text = movieInfo.movieDescription ?? ""
            if (movieInfo.movieDescription ?? "").count > self.readMoreTextLimit{
                self.stackReadmore.isHidden = false
            }else{
                self.stackReadmore.isHidden = true
            }
            self.vwRateThisMoview.isHidden = true
            if let paymentStatus = movieInfo.paymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.btnBookNow.setTitle(ZTConstants.BTN_BOOK_PLAY, for: .normal)
                self.vwRateThisMoview.isHidden = false
                self.btnWriteAReview.isHidden = false
            }else{
                self.btnBookNow.setTitle(ZTConstants.BTN_BOOK_NOW, for: .normal)
                self.vwRateThisMoview.isHidden = true
                self.btnWriteAReview.isHidden = true
            }
            self.lblMovieName.text = movieInfo.movieName
            self.lblMovieLanguage.text = movieInfo.primaryLanguage
            if let movieTime = movieInfo.runningTime{
               let convertToSec = Double(movieTime * 60)
                let stringVal = convertToSec.asString(style: .short)
                self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
            }
            self.lblExclusiveText.text = String(format: "%@ %@", movieInfo.promoLabel ?? "", (movieInfo.iosTicketPrice ?? 0).getPriceValue())
            
            Helper.shared.loadImage(url: movieInfo.moviePoster ?? "", imageView: self.imgVwMovieBanner)
            self.lblRating.text = String(format: "%.1f", movieInfo.avgRating ?? 0)
            self.lblMovieAge.text = String(format: "%d+", Int(movieInfo.ageRating ?? 0))
            self.lblMovieYear.text = String(format: "%d", Int(movieInfo.yearReleased ?? 0))
            self.lblReviesCount.text = String(format: "%d Reviews", Int(movieInfo.overallRank ?? 0))
            self.collectionCast.reloadData()
            self.collectionCrew.reloadData()

            self.collectionGenre.reloadData()
            if self.moviewDetails?.movieGenres?.count ?? 0 > 0 {
                self.collectionGenre.reloadData()
                self.stackGenre.isHidden = false
            }else{
                self.stackGenre.isHidden = true
            }
            if self.moviewDetails?.movieActors?.count ?? 0 > 0{
                self.stackCast.isHidden = false
            }else{
                self.stackCast.isHidden = true
            }
            if self.moviewDetails?.movieCrew?.count ?? 0 > 0{
                self.stackCrew.isHidden = false
            }else{
                self.stackCrew.isHidden = true
            }
            self.vwTeaser.isHidden = true
            self.vwTrailer.isHidden = true
            if let teaser = self.moviewDetails?.teaserUrl, teaser.count > 0{
                self.vwTeaser.isHidden = false
                Helper.shared.loadImage(url: self.moviewDetails?.thumbnail ?? "", imageView: self.imgVwTeaser)
            }
            if let trailer = self.moviewDetails?.trailorUrl, trailer.count > 0{
                self.vwTrailer.isHidden = false
                Helper.shared.loadImage(url: self.moviewDetails?.thumbnail ?? "", imageView: self.imgVwTrailer)
            }
            self.lblTblReviewsCount.text = String(format: "%d Reviews", Int(movieInfo.overallRank ?? 0))
            if self.moviewDetails?.movieActors?.count ?? 0 > 0{
                self.stackGenre.isHidden = false
            }else{
                self.stackGenre.isHidden = true
            }
            self.getRecommendedMovies()
            self.getMovieReviews()
            self.getMovieSeasons()
        }
    }
    @IBAction func btnWriteAReview(_ sender: Any) {
        self.playerView.pause(allowAutoPlay: false)
        Helper.shared.gotoWriteAReview(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnMoreReviews(_ sender: Any) {
        
        Helper.shared.goToRatingsReviews(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnTeaserPlay(_ sender: Any) {
        self.loadVideo(strUrl: self.moviewDetails?.teaserUrl ?? "")
    }
    func loadVideo(strUrl:String, seekTime:Int64? = 0, subsURl:String? = "", nameStr:String? = ""){
        debugPrint("nameStr\(nameStr)")
        if let url = URL.init(string: strUrl) {
        
            var timeInterval = Double(seekTime ?? 0)//68// Double((seekTime ?? 0) * 60)
            if self.isDirectEpisodeWatchNow == false{
                if self.isDirect_Epi_Seek == false{
                    timeInterval = 0
                }
            }
            self.isDirectEpisodeWatchNow = true
            self.isDirect_Epi_Seek = false
        self.videoPlayerView.isHidden = false
        self.playerView.backBlock = { [unowned self] (isFullScreen) in
                if isFullScreen == true {
                    return
                }
                self.multiplierHeightChange(sizeVal: self.videoBannerSize)
                self.btnBack.isHidden = false
                self.videoPlayerView.isHidden = true
            }
            self.playerView.playerLayer?.resetPlayer()

            var subtitle:BMSubtitles? = nil
            if subsURl?.count ?? 0 > 0{
                let subTitleUrlVal = URL.init(string: subsURl ?? "")
                subtitle = BMSubtitles(url: subTitleUrlVal!)
            }
            
            let asset = BMPlayerResource(name: nameStr ?? "", definitions: [BMPlayerResourceDefinition(url: url, definition: "")], cover: nil, subtitles: subtitle)
//            let asset = BMPlayerResource(url: url)
            self.playerView.delegate = self
            self.playerView.setVideo(resource: asset)
            self.playerView.seek(timeInterval, completion: nil)
            self.multiplierHeightChange(sizeVal: self.videoPlayerSize)
            self.btnBack.isHidden = true
        }
    }
    @IBAction func btnTrailerPlay(_ sender: Any) {
        
        self.loadVideo(strUrl: self.moviewDetails?.trailorUrl ?? "")

    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func checkMoviePaymentStatus(){
        if let paymentStatus = self.moviewDetails?.paymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
            self.getMovieLink()

        }else{
            Helper.shared.goToChoosePlan(viewController: self, movieInfo: self.moviewDetails)
        }
    }
    func refreshReadmoreUI(){
        if self.readMoreClicked == true{
            self.lblMovieDescription.numberOfLines = 0
            self.btnReadMore.setTitle(ZTConstants.BTN_READLESS, for: .normal)
            self.view.setNeedsDisplay()
        }else{
            self.lblMovieDescription.numberOfLines = 2
            self.btnReadMore.setTitle(ZTConstants.BTN_READMORE, for: .normal)
            self.view.setNeedsDisplay()
        }
    }
    @IBAction func btnReadMoreTapped(_ sender: Any) {
        self.readMoreClicked = !self.readMoreClicked
        self.refreshReadmoreUI()
    }
    @IBAction func btnRateThisMovieTapped(_ sender: Any) {
        self.playerView.pause(allowAutoPlay: false)
        Helper.shared.gotoWriteAReview(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnReviewsTapped(_ sender: Any) {
        Helper.shared.goToRatingsReviews(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnBookNowTapped(_ sender: Any) {
        self.checkMoviePaymentStatus()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension ZTMovieDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionCast{
            return self.moviewDetails?.movieActors?.count ?? 0
        }else if collectionView == self.collectionCrew{
            return self.moviewDetails?.movieCrew?.count ?? 0
        }else if collectionView == self.collectionRecommended{
            return self.recommendedMovies?.count ?? 0
        }else if collectionView == self.collectionGenre{
            return self.moviewDetails?.movieGenres?.count ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionCast{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, for: indexPath) as! ZTCrewCollectionViewCell
            cell.loadCastDetails(data: self.moviewDetails?.movieActors?[indexPath.row])
            return cell

        }else if collectionView == self.collectionCrew{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, for: indexPath) as! ZTCrewCollectionViewCell
            cell.loadCrewDetails(data: self.moviewDetails?.movieCrew?[indexPath.row])
            return cell

        }else if collectionView == self.collectionGenre{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
            cell.loadData(data: self.moviewDetails?.movieGenres?[indexPath.row].genre, indexPath: indexPath)
            return cell

        }else if collectionView == self.collectionRecommended{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, for: indexPath) as! ZTPortraitVideoCollectionViewCell
            let modelVal = self.recommendedMovies?[indexPath.row]
            cell.loadPortraitVideos(data: modelVal, isExclusiveHide: false)
            return cell
        }
        else{ // Teaser cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
           
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionCast{
            return CGSize(width: 80, height:  collectionView.frame.size.height)
        }else if collectionView == self.collectionCrew{
            return CGSize(width: 80, height:  collectionView.frame.size.height)
        }else if collectionView == self.collectionRecommended{
            return CGSize(width: 133, height: collectionView.frame.size.height)
        }else if collectionView == self.collectionGenre{
            let item = self.moviewDetails?.movieGenres?[indexPath.row].genre?.genreName ?? ""
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let size = CGSize(width: 120, height: collectionView.frame.size.height)
            let estimatedFrame = NSString(string: item).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.setAppFontRegular(13.0)], context: nil)
            let attributes = [NSAttributedString.Key.font : UIFont.setAppFontRegular(13.0)]

            let yourLabelSize: CGSize = item.size(withAttributes:attributes )
                
            var width1 = yourLabelSize.width
            if width1 < 120 {
                    width1 = 120
            }
            return CGSize(width: estimatedFrame.width + 20, height: collectionView.frame.size.height)
        }else{
            return CGSize(width: 0, height:  0)
        }
    }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionRecommended{
            if let movieInfo = self.recommendedMovies?[indexPath.row]{
                Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: 1, height:collectionView.frame.size.height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height:collectionView.frame.size.height)
        }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionRecommended{
            return 10
        }
        return 5
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionRecommended{
            return 1
        }
        return 5
    }
}

//TableView Delegate
extension ZTMovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.moviewReviews?.count ?? 0 > 2{
            return 2
        }else{
            return self.moviewReviews?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTUserReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, for: indexPath) as! ZTUserReviewTableViewCell
        cell.selectionStyle = .none
        cell.loadReviews(data: self.moviewReviews?[indexPath.row], indexPath: indexPath)
        return cell
    }
}
extension ZTMovieDetailViewController{
    func getMovieSeasons(){
        if NetworkReachability.shared.isReachable {
//            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.movieSeasonsByMovieCommon(movieId: self.moviewDetails?.movieId ?? -1, pageNumber: 0, pageSize: 100, sortSorted: true) { response, error in
                self.movieSeasons?.removeAll()
//                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    
                    DispatchQueue.main.async {
                        self.movieSeasons?.append(contentsOf: responseVal.content ?? [])
                        var orderVal : Int = 0
                        
                        self.movieSeasons =  self.movieSeasons?.sorted { $0.ordering ?? 0 < $1.ordering ?? 0 }
                      

                        for var i in self.movieSeasons ?? []{
                            i.movieEpisodes =  i.movieEpisodes?.sorted { $0.ordering ?? 0 < $1.ordering ?? 0 }
                            for j in i.movieEpisodes ?? []{
                                let nxtMovEpi = NextMovieSeasonEpisode(movieId: self.moviewDetails?.movieId, seasonId: i.seasonId, episodeId: j._id, seasonModel: i, episodeModel: j, orderVal: orderVal)
                                orderVal += 1
                                self.nextMovieSeasonEpisode.append(nxtMovEpi)
                            }
                        }
                        
                        if self.movieSeasons?.count ?? 0 > 0{
                            self.stackSeason.isHidden = false
                            self.carbonInitialize()
                        }else{
                            self.stackSeason.isHidden = true
                        }
                    }
                }
            }
        }
    }
    func getMovieDetails(){
        var movieIdVal: Int64 = -1
        if let moviewDe = self.moviewDetails{
            movieIdVal = moviewDe.movieId ?? -1
        }else{
            movieIdVal = self.transMovieId ?? -1
        }
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.getMovieUsingGET(movieId: movieIdVal) { response, error in
                
            self.hideActivityIndicator(self.view)
                
            if error != nil{
                WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                    
                }, failureBlock: { (errorMsg) in
                   
                })
                return
            }
            if let responseVal = response{
                self.currentMovieId = movieIdVal//self.moviewDetails?.movieId ?? -1
                self.moviewDetails = nil
                self.moviewDetails = responseVal

                DispatchQueue.main.async {
                    self.initialLoad()
                }
            }
        }
        }
    }
    func getRecommendedMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.movieSearchAvg.rawValue, page: 0, size: 50) { (response, error) in
                self.recommendedMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.recommendedMovies?.append(contentsOf: responseVal.content ?? [])
                    if self.recommendedMovies?.count ?? 0 > 0{
                        self.stackRecommended.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.collectionRecommended.reloadData()
                    }
                }
            }
        }
    }
    func getMovieReviews(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.movieReviewsByMovie(movieId: self.moviewDetails?.movieId ?? -1, sort: SortingStruct.sort_createdOn_desc.rawValue) { response, error in
                self.moviewReviews?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.moviewReviews?.append(contentsOf: responseVal.content ?? [])
                    if self.moviewReviews?.count ?? 0 > 0{
                        self.stackReviews.isHidden = false
                        if self.moviewReviews?.count ?? 0 > 2{
                            self.btnMoreReview.isHidden = false
                        }else{
                            self.btnMoreReview.isHidden = true
                        }
                    }else{
                        self.btnMoreReview.isHidden = true
                    }
                    DispatchQueue.main.async {
                        self.tblReviews.reloadData()
                    }
                }
            }
        }
    }
    func getMovieLink(){
        if NetworkReachability.shared.isReachable {
            let playMovieRequest = PlayMovieRequest(ipAddress: device_uuid, movieId: self.moviewDetails?.movieId ?? -1, seasonId: self.movieSeasonId, episodeId: self.seasonEpisodeId)
            
            ZTCommonAPIWrapper.getMovieVideoWUsingPOST(playMovieRequest: playMovieRequest) { response, error in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    DispatchQueue.main.async {
                        self.movieLinkModel = responseVal

                        if self.moviewDetails?.movieType == MovieTypes.WebSeries.rawValue{
                            if self.isDirectEpisodeWatchNow == false{
                                if self.movieLinkModel?.episodeId == self.seasonEpisodeId{
                                    self.isDirect_Epi_Seek = true
                                }
                                self.movieLinkModel?.episodeId = self.seasonEpisodeId
                                self.movieLinkModel?.seasonId = self.movieSeasonId
                            }
                        }
                        self.getMovieLinkDetails()
                    }
                }
            }
            
        }
    }
    func getMovieLinkDetails(){
        if self.moviewDetails?.movieType == MovieTypes.WebSeries.rawValue{
                        if self.movieLinkModel?.seasonId != 0{
                            if let movieSeasonsVal = self.movieSeasons?
                                .first(where: { $0.seasonId == self.movieLinkModel?.seasonId ?? 0 }){
                                if let episodesVal = movieSeasonsVal.movieEpisodes?.first(where: { $0._id == self.movieLinkModel?.episodeId ?? 0 }){
                                    self.seasonEpisodeId = episodesVal._id ?? 0
                                    self.movieSeasonId = movieSeasonsVal.seasonId ?? 0
                                    debugPrint("after movie link details self.seasonEpisodeId \(self.seasonEpisodeId) self.movieSeasonId\(self.movieSeasonId)")
                                    self.loadVideo(strUrl: episodesVal.sourceUrl ?? "", seekTime: self.movieLinkModel?.initialSeekTime ?? 0, nameStr: episodesVal.name ?? "")
                                }
                            }
                        }else{
                            self.movieSeasonId = self.movieSeasons?[0].seasonId ?? 0
                            self.seasonEpisodeId = self.movieSeasons?[0].movieEpisodes?[0]._id ?? 0
                            
                            let linkVal = self.movieSeasons?[0].movieEpisodes?[0].sourceUrl ?? ""
                            self.loadVideo(strUrl: linkVal, nameStr: self.movieSeasons?[0].movieEpisodes?[0].name ?? "")
                        }
                    }else {
                        var subsURL:String = ""
                        if let filteredVal = self.moviewDetails?.movieSubtitles?.filter({ $0.subType?.lowercased() == ZTDefaultValues.iOS_Subtitle.lowercased()}), filteredVal.count > 0{
                            subsURL = filteredVal[0].subUrl ?? ""
                        }
                        self.loadVideo(strUrl: self.movieLinkModel?.movieUrl ?? "", seekTime: self.movieLinkModel?.initialSeekTime ?? 0, subsURl: subsURL, nameStr: self.movieLinkModel?.movieName ?? "")
                    }
    }
}
extension ZTMovieDetailViewController:WriteAReviewDelegate{
    func updateUI() {
        self.getMovieDetails()
    }
    func updateVideoPlayTime(currentTime:TimeInterval, elapsedTime:TimeInterval){
        if let paymentStatus = self.moviewDetails?.paymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue, let playID = self.movieLinkModel?.moviePlayId, playID > 0{
        
            let watch  = currentTime// Double( currentTime.asSecondsString())
            debugPrint("watch \(watch)")
        var playDuration:String = "0"
            if elapsedTime != 0{
                playDuration = elapsedTime.asMinutesString()
            }
        let dateStr = Helper.shared.getFormatedDate(dateVal: Date(), dateFormat: CustomDateFormatter.orderRequestDate)
        
        var seasonIdVal:Int64 = 0
        var episodeIdVal:Int64 = 0
        let movieIdVal:Int64 = self.moviewDetails?.movieId ?? 0

        if self.moviewDetails?.movieType == MovieTypes.WebSeries.rawValue{
            seasonIdVal = self.movieSeasonId
            episodeIdVal = self.seasonEpisodeId
//            movieIdVal = 0
        }
            let moviePlays = MoviePlays(country: nil, createdBy: nil, createdOn: nil, deviceInfo: nil, ipAddress: device_uuid, lastUpdateLogin: nil, modifiedBy: nil, modifiedOn: nil, movieId: movieIdVal, moviePlayId: self.movieLinkModel?.moviePlayId ?? -1, operatingSystem: "iOS", playEndTime: dateStr, playSeekTime: Int64(watch ?? 0),seasonId: seasonIdVal, episodeId: episodeIdVal, playStartTime: nil, timezone: nil, userId: ZTAppSession.sharedInstance.getUserInfo()?.userId, versionNumber: nil, playDuration:Int64(playDuration))
       
        if NetworkReachability.shared.isReachable {
            
            ZTCommonAPIWrapper.updateMoviePlayTime(moviePlay: moviePlays, moviePlayId: self.movieLinkModel?.moviePlayId ?? -1) { response, error in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.totalElapsed = 0
                    self.resetTimer()
                }
            }
        }
    }
    }
}
extension ZTMovieDetailViewController:BMPlayerDelegate{
    func getNextSeasonEpisode(){
        
        if let paymentStatus = self.moviewDetails?.paymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
            if self.nextMovieSeasonEpisode.count > 0{
                if let index = self.nextMovieSeasonEpisode.firstIndex(where: { $0.seasonId ?? 0 == self.movieSeasonId && $0.episodeId ?? 0 == self.seasonEpisodeId}){
                    let modelVal = self.nextMovieSeasonEpisode[index]
                    let lastModel = self.nextMovieSeasonEpisode[self.nextMovieSeasonEpisode.count - 1]
                    if modelVal.orderVal == lastModel.orderVal{
                        self.isLastSeasonVideo = true
                    }else{
                        self.isLastSeasonVideo = false
                        let nxtVal = self.nextMovieSeasonEpisode[index + 1]
                        self.seasonEpisodeId = nxtVal.episodeId ?? 0
                        self.movieSeasonId = nxtVal.seasonId ?? 0
                        
                        debugPrint("before movie link details self.seasonEpisodeId \(self.seasonEpisodeId) self.movieSeasonId\(self.movieSeasonId)")
                        
                        
                        self.getMovieLink()
//                        self.loadVideo(strUrl: nxtVal.episodeModel?.sourceUrl ?? "", nameStr: nxtVal.episodeModel?.name ?? "")
                    }
                }
            }
        }
        
    }
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        switch state {
        case .readyToPlay:
            self.playerView.play()
            self.startTimer()
            break
        case .buffering:
            self.pauseTimer()
            break
        case .bufferFinished:
            self.startTimer()
            break
        case .playedToTheEnd:
            if self.moviewDetails?.movieType == MovieTypes.WebSeries.rawValue{
                self.updateVideoPlayTime(currentTime: self.currentDuration, elapsedTime: self.totalElapsed)
                self.getNextSeasonEpisode()
            }else{
                
                self.updateVideoPlayTime(currentTime: self.currentDuration, elapsedTime: self.totalElapsed)
                self.resetTimer()
            }
            break
        default: break
            
        }
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
        self.currentDuration = currentTime
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        debugPrint("Player playing\(playing)")
        if playing == false{
            self.currentDuration = player.currentPosition
//            if self.moviewDetails?.movieType == MovieTypes.WebSeries.rawValue{
//
//            }else{
//                self.updateVideoPlayTime(currentTime: self.currentDuration)
//            }
            self.updateVideoPlayTime(currentTime: self.currentDuration, elapsedTime: self.totalElapsed)

        }else{
            self.startTimer()
        }
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
    
}
extension ZTMovieDetailViewController {
    
    func setUp(text: String, characterSpacing: Float)-> NSAttributedString{
           let attributedString = NSMutableAttributedString(string: text)
           attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
          return attributedString
    }

    func carbonInitialize() {
       
        carbonKitTabs.removeAll()
        for i in self.movieSeasons ?? []{
            let seasonModel = i
            carbonKitTabs.append(seasonModel.name ?? "")
        }
        zTSeasonVideoListViewController?.tagNum = 0
        zTSeasonVideoListViewController?.movieSeasons = self.movieSeasons ?? []
        self.zTSeasonVideoListViewController?.viewHeight = Int(self.carbonKitSeasonView.bounds.height - 40)
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: carbonKitTabs as [AnyObject], delegate: self)
        self.style()
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.carbonKitSeasonView)
    }
    
    func style() {
        
        let color: UIColor = UIColor.getColor(colorVal: ZTGradientColor1)
        carbonTabSwipeNavigation.toolbar.isTranslucent = true
         carbonTabSwipeNavigation.toolbar.clipsToBounds = true
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.setTabBarHeight(40)
       
        carbonTabSwipeNavigation.toolbar.backgroundColor = UIColor.getColor(colorVal: ZTBackgroundColor)
        carbonTabSwipeNavigation.setIndicatorHeight(2.0)
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor.getColor(colorVal: ZTBackgroundColor)
 
        let font = UIFont.setAppFontMedium(16)

        carbonTabSwipeNavigation.setNormalColor(UIColor.getColor(colorVal: ZTAppBlackColor), font: font )
        carbonTabSwipeNavigation.currentTabIndex = homeCarbonSelectedSegment
        carbonTabSwipeNavigation.setSelectedColor(UIColor.getColor(colorVal: ZTGradientColor1), font: font)
        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = true
    
    }
    
}
// MARK:- Carbon Kit delegates

extension ZTMovieDetailViewController: CarbonTabSwipeNavigationDelegate {

    func refreshVideo(){
        
    }
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return zTSeasonVideoListViewController!
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        zTSeasonVideoListViewController?.tagNum = Int(index)
        zTSeasonVideoListViewController?.initialLoad()
    }
    @objc func videoRefresh(_ notification:NSNotification){
        
            self.updateVideoPlayTime(currentTime: self.currentDuration, elapsedTime: self.totalElapsed)
        debugPrint("before movie link details self.seasonEpisodeId \(self.seasonEpisodeId) self.movieSeasonId\(self.movieSeasonId)")
        
        if let args = notification.object as? SeasonVideoStruct{
            if let paymentStatus = self.moviewDetails?.paymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.movieSeasonId = args.movieSeason?.seasonId ?? 0
                self.seasonEpisodeId = args.movieEpisodes?._id ?? 0
                self.isDirectEpisodeWatchNow = false
                self.getMovieLink()
//                self.loadVideo(strUrl: args.movieEpisodes?.sourceUrl ?? "", nameStr: args.movieEpisodes?.name ?? "")
            }
        }
    }
}
extension ZTMovieDetailViewController{
    
    func startTimer(){
        if displayLink == nil {
                    startDisplayLink()
        }
    }
    func pauseTimer(){
        priorElapsed += elapsed
                elapsed = 0
                displayLink?.invalidate()
    }
    func resetTimer(){
        stopDisplayLink()
        priorElapsed = 0
                elapsed = 0
        self.updateUITimer()
    }
    func startDisplayLink() {
            startTime = CACurrentMediaTime()
            let displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
            displayLink.add(to: .main, forMode: .common)
            self.displayLink = displayLink
        }

        func stopDisplayLink() {
            displayLink?.invalidate()
        }

        @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
            guard let startTime = startTime else { return }
            elapsed = CACurrentMediaTime() - startTime
            updateUITimer()
        }

        func updateUITimer() {
            self.totalElapsed = elapsed + priorElapsed

//            let hundredths = Int((totalElapsed * 100).rounded())
//            let (minutes, hundredthsOfSeconds) = hundredths.quotientAndRemainder(dividingBy: 60 * 100)
//            let (seconds, milliseconds) = hundredthsOfSeconds.quotientAndRemainder(dividingBy: 100)
//
//            minutesLabel.text = String(minutes)
//            secondsLabel.text = String(format: "%02d", seconds)
//            milliSecondsLabel.text = String(format: "%02d", milliseconds)
        }

}
