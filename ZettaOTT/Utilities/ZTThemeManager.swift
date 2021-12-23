//
//  RHThemeManager.swift
//  RazielHealth
//
//  Created by Dinesh-iMac on 04/04/21.
//

import Foundation
import UIKit
let ZTAppBlackColor = "ZTAppBlackColor"
let ZTAppSeperatorColor = "ZTAppSeperatorColor"
let ZTBackgroundColor = "ZTBackgroundColor"
let ZTFBBackgroundColor = "ZTFBBackgroundColor"
let ZTFormBackgroundColor = "ZTFormBackgroundColor"
let ZTGradientColor1 = "ZTGradientColor1"
let ZTGradientColor2 = "ZTGradientColor2"
let ZTMoreColor = "ZTMoreColor"
let ZTTabbarSelectedColor = "ZTTabbarSelectedColor"
let ZTTabbarUnSelectedColor = "ZTTabbarUnSelectedColor"
let ZTTermsColor = "ZTTermsColor"
let ZTOTPBorderColor = "ZTOTPBorderColor"
let ZTAppProfileBorder = "ZTAppProfileBorder"
let ZTReviewPageGreyColor = "ZTReviewPageGreyColor"
let ZTSuccessColor = "ZTSuccessColor"
let ZTFailureColor = "ZTFailureColor"
let ZTAppWhiteColor = "ZTAppWhiteColor"
let ZTPaymentNewColor = "ZTPaymentNewColor"

class ThemeManager: NSObject {
    
}

public extension UIColor {
    
    class func getColor(colorVal:String) -> UIColor{
        return UIColor.init(named: colorVal) ?? appThemeColor()
    }
    class func appThemeColor()->UIColor{
        return UIColor.init(named: ZTBackgroundColor) ?? .black
    }
}


extension UIFont {
    class func setAppFontBlack(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Black", size: size)!
    }
    
    class func setAppFontBold(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Bold", size: size)!
    }
    
    class func setAppFontExtraBold(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Heavy", size: size)!
    }
    
    class func setAppFontLight(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Light", size: size)!
    }
    
    class func setAppFontMedium(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Medium", size: size)!
    }
    
    class func setAppFontRegular(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Regular", size: size)!
    }
    
    class func setAppFontSemiBold(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-SemiBold", size: size)!
    }
    
    class func setAppFontThin(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Thin", size: size)!
    }
    class func setAppFontUltraLight(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "SFUIDisplay-Ultralight", size: size)!
    }
    
}

// MARK: - Extensions
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    public func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}


extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}

