import Foundation
import UIKit
import FlagPhoneNumber
import JVFloatLabeledTextField

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
          var size = super.sizeThatFits(size)
        size.height = 84
          return size
     }
}
class ZTCircularImageView: UIImageView {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        func setup() {
            self.layer.cornerRadius = self.bounds.size.width / 2
            self.clipsToBounds = true
        }
}
class ZTImageViewCornerRadius: UIImageView {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        func setup() {
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
        }
}
class ZTCornerRadiusView: UIButton {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        func setup() {
            self.layer.cornerRadius = 5
            self.layer.masksToBounds = true
        }
}

class ZTGradientView: UIView {
        var firstColor: UIColor = UIColor.getColor(colorVal: ZTGradientColor1)
        var secondColor: UIColor = UIColor.getColor(colorVal: ZTGradientColor2)
        var vertical: Bool = false
    
        lazy var gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [firstColor.cgColor, secondColor.cgColor]
            layer.startPoint = CGPoint.zero
            return layer
        }()
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            applyGradient()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            applyGradient()
        }
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            applyGradient()
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            updateGradientFrame()
        }
        func applyGradient() {
            updateGradientDirection()
            layer.sublayers = [gradientLayer]
        }
        func updateGradientFrame() {
            gradientLayer.frame = bounds
        }
        func updateGradientDirection() {
            gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        }
}

class ZTCustomHeaderShadowView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    private func setUp() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.10
        self.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }
}

class ZTRoundedCornerLabel: UILabel{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  self.frame.size.width / 2
        self.layer.masksToBounds = true
    }
}

class BackButtonAutoWidth: UIButton {
    override var intrinsicContentSize: CGSize {
        return titleLabel!.sizeThatFits(CGSize(width: titleLabel!.preferredMaxLayoutWidth, height: .greatestFiniteMagnitude))
    }
    override func layoutSubviews() {
        titleLabel?.preferredMaxLayoutWidth = frame.size.width
        super.layoutSubviews()
    }
}

class ZTRoundedCornerButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  28
        self.layer.masksToBounds = false
    }
}


class ZTSmallCornerRadiusButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  16
        self.layer.masksToBounds = true
    }
}
class ZTCallCornerRadiusButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  22
        self.layer.masksToBounds = true
    }
}

class ZTMinCornerRadiusButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  24
        self.layer.masksToBounds = true
    }
}

class ZTCornerRadiusBottoButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  30
        self.layer.masksToBounds = true
    }
}
class ZTRoundedCornerWithTitlePaddingButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  25
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 0.0)
        self.layer.masksToBounds = true
    }
}


class ZTCornerRadiusBorderBottomButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius =  30
        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.init(named: COLOR_APP_WHITE)?.cgColor
        
    }
    
}


final class ZTContentSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
     
     override func reloadData() {
       super.reloadData()
       self.invalidateIntrinsicContentSize()
       self.layoutIfNeeded()
     }
    
    override var intrinsicContentSize: CGSize {
       setNeedsLayout()
       layoutIfNeeded()
       let height = min(contentSize.height, maxHeight)
       return CGSize(width: contentSize.width, height: height)
    }
}

class ZTMinCornerRadiusView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }

    private func setUp() {
        self.layer.cornerRadius = 10.0
    }
}



class ZTMaxCornerRadiusView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }

    private func setUp() {
        self.layer.cornerRadius = 25.0
    }
}

class ZTShadowView: UIView{
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    private func setUp() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        self.layer.shadowRadius = 5
    }
}

class ZTCornerRadiusButton: UIButton{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        
        self.layer.cornerRadius = 10
        
    }
    
    class ZTCircleButton: UIButton{
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        func setUp(){
            
            self.layer.cornerRadius = self.frame.size.width / 2
            self.layer.masksToBounds = true
            
        }
    }
    
}
class ZTGradientImageView: UIImageView{

    let myGradientLayer: CAGradientLayer

 override init(frame: CGRect){
    myGradientLayer = CAGradientLayer()
    super.init(frame: frame)
    self.setup()
    addGradientLayer()
 }

 func addGradientLayer(){
    if myGradientLayer.superlayer == nil{
        self.layer.addSublayer(myGradientLayer)
    }
 }

    required init?(coder aDecoder: NSCoder){
    myGradientLayer = CAGradientLayer()
    super.init(coder: aDecoder)
    self.setup()
    addGradientLayer()
 }

    func getColors() -> [CGColor] {
        return [UIColor.clear.cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor]
 }

 func getLocations() -> [CGFloat]{
    return [0.0,  1.0]
 }

 func setup() {
     myGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
     myGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

     let colors = getColors()
     myGradientLayer.colors = colors
    myGradientLayer.isOpaque = false
    myGradientLayer.locations = getLocations() as [NSNumber]
    self.contentMode = .scaleAspectFill
 }

 override func layoutSubviews() {
    super.layoutSubviews()
    myGradientLayer.frame = self.layer.bounds
 }
}

class ZTPhoneCustomTextField: FPNTextField{
    var errorLabel: UILabel? = nil
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    
    func setUp(){
        self.tintColor = UIColor.getColor(colorVal: ZTTabbarSelectedColor)
        self.textColor = UIColor.getColor(colorVal: ZTTabbarUnSelectedColor)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.getColor(colorVal: ZTAppSeperatorColor)])
        self.setBottomBorder(color: UIColor.getColor(colorVal: ZTAppSeperatorColor))
    }
    func showError(){
        setError()
    }
    func removeError() {
        self.removeErrorMessage()
    }
    
    func removeErrorMessage(){
        if self.errorLabel != nil{
            self.errorLabel?.removeFromSuperview()
        }
    }
    
    func setError() {
        
        if errorLabel == nil{
            errorLabel = UILabel()
        }
        else{
            errorLabel?.removeFromSuperview()
        }
        // Create message
        errorLabel?.text = ""
        errorLabel?.backgroundColor = UIColor.getColor(colorVal: ZTTabbarSelectedColor)
        errorLabel?.numberOfLines = 1
        let width = CGFloat(1.0)
        errorLabel?.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: 1)
        self.addSubview(errorLabel!)
    }
}
class ZTCustomTextField: JVFloatLabeledTextField{
    var errorLabel: UILabel? = nil
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    func setUp(){
        self.tintColor = UIColor.getColor(colorVal: ZTTabbarSelectedColor)
        self.textColor = UIColor.getColor(colorVal: ZTTabbarUnSelectedColor)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.getColor(colorVal: ZTAppSeperatorColor)])
        self.setBottomBorder(color: UIColor.getColor(colorVal: ZTAppSeperatorColor))
    }
    func showError(){
        setError()
    }
    func removeError() {
        self.removeErrorMessage()
    }
    
    func removeErrorMessage(){
        if self.errorLabel != nil{
            self.errorLabel?.removeFromSuperview()
        }
    }
    
    func setError() {
        
        if errorLabel == nil{
            errorLabel = UILabel()
        }
        else{
            errorLabel?.removeFromSuperview()
        }
        // Create message
        errorLabel?.text = ""
        errorLabel?.backgroundColor = UIColor.getColor(colorVal: ZTTabbarSelectedColor)
        errorLabel?.numberOfLines = 1
        let width = CGFloat(1.0)
        errorLabel?.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: 1)
        self.addSubview(errorLabel!)
    }
}
extension UITextField {
 
    func removeBottomBorder(){
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.removeFromSuperlayer()
    }
    func setBottomBorder(color:UIColor) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
  }
}
class ZTButtonWithImageRightSide: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}
