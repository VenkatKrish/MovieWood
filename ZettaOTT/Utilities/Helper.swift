//
//  Helper.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//
import Foundation
import UIKit
import TTGSnackbar
import Kingfisher

enum SnackBarType {
    case Failure
    case Success
    case Warning
    case InfoOrNotes
    case Toast
}
protocol HelperMethodsDelegate {
    func missingDataActionTapped()
}
class Helper: NSObject {
    var snackBar : TTGSnackbar? = nil
    var helperDelegate : HelperMethodsDelegate!
    var noRecordsView = NoRecordsView()
    
    class var shared: Helper {
        struct Static {
            static let instance: Helper = Helper()
        }
        return Static.instance
    }
    func getRandomColor(indexVal:Int) -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(colorRandom.count)))
        print(colorRandom[randomIndex])
        return colorRandom[indexVal]
       
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return ZTAppSession.sharedInstance.userDefaults.object(forKey: key) != nil
    }
    func isValidEmailAddress (strValue:String)-> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [.caseInsensitive])
        return regex.firstMatch(in: strValue, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, strValue.count)) != nil
    }
    func loadImage(url:String, imageView:UIImageView, placeHolder:String? = nil){
        var placeholderImage:UIImage? = nil
        if let placeHolderVal = placeHolder {
            placeholderImage = UIImage(named: placeHolderVal)
        }
        let finalUrl = ZTDefaultValues.imageBaseURL + url
        let url = URL(string: finalUrl)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 5)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let _):
                imageView.backgroundColor = .clear
                break
//                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let _):
                imageView.backgroundColor = .clear
                break
//                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    // for show the snack bar alert
    func showSnackBarAlert(message: String, type: SnackBarType, superView: UIViewController? = nil) {
        if(self.snackBar != nil)
        {
            self.snackBar?.dismiss()
        }
       
        self.snackBar = TTGSnackbar(message: message, duration: .middle)
        snackBar?.messageTextColor = UIColor.white
        snackBar?.messageTextAlign = .center
//        snackBar?.containerView = superView.view
            snackBar?.show()
            switch type {
            case .Success:
                snackBar?.backgroundColor = UIColor.green
                break
            case .Failure:
                snackBar?.backgroundColor = UIColor.red
                break
            case .Warning:
                snackBar?.backgroundColor = UIColor.yellow
                break
            case .InfoOrNotes:
                snackBar?.backgroundColor = UIColor.white
                break
            case .Toast:
                snackBar?.backgroundColor = UIColor.white
                snackBar?.messageTextColor = UIColor.white
                break
            }
        
        
    }
}

extension String {
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x1F1E6...0x1F1FF, // Regional country flags
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F,   // Variation Selectors
            0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
            127000...127600, // Various asian characters
            65024...65039, // Variation selector
            9100...9300, // Misc items
            8400...8447:
                return true
            default:
                continue
            }
        }
        return false
    }
        func toJSON() -> Any? {
            guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        }
    func isAlphanumeric() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
    
    func isAlphanumeric(ignoreDiacritics: Bool = false) -> Bool {
        if ignoreDiacritics {
            return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil && self != ""
        }
        else {
            return self.isAlphanumeric()
        }
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
// Roots
extension Helper{
    func getWindow()-> UIWindow?{
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return nil
          }
          return sceneDelegate.window
    }
    func getMovieSearchTag(movieTag:String) -> String{
        var searchKey : String = ""
        if movieTag == moviesKeyUI.zetta_movies_originals{
            searchKey =   MovieSearchTag.zettaMovieOriginal.rawValue
        }else if movieTag == moviesKeyUI.latest_tamil_movies{
            searchKey =  MovieSearchTag.movieSearchAvg.rawValue
        }else if movieTag == moviesKeyUI.recommended{
            searchKey =  MovieSearchTag.movieSearchAvg.rawValue
        }else if movieTag == moviesKeyUI.popular_movies{
            searchKey =  MovieSearchTag.movieSearchAvg.rawValue
        }else if movieTag == moviesKeyUI.latest_web_series{
            searchKey =  MovieSearchTag.webSeries.rawValue
        }
        return searchKey
    }
    func getUserWithCompletion(completion: @escaping ((_ data: AppUserModel?,_ error: Error?) -> Void)){
        if NetworkReachability.shared.isReachable{
            ZTCommonAPIWrapper.getMyProfileUsingGET { (response, error) in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    ZTAppSession.sharedInstance.setUserInfo(data: responseVal)
                    completion(responseVal, error)
                }
            }
        }
    }
    func getUserBackground(){
        if NetworkReachability.shared.isReachable{
            ZTCommonAPIWrapper.getMyProfileUsingGET { (response, error) in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    ZTAppSession.sharedInstance.setUserInfo(data: responseVal)
                }
            }
        }
        
    }
    func validateFirstLogin(){
        if let loginInfo = ZTAppSession.sharedInstance.getLoginInfo(){
            if loginInfo.firstLogin?.lowercased() == FirstLogin.FirstLogin_YES.rawValue.lowercased(){
                ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
                self.goToSignupRoot()
            }else{
                ZTAppSession.sharedInstance.setIsUserLoggedIn(true)
                Helper.shared.goToHomeScreen()
            }
        }
    }
    func validateAfterLogin(loginModel:LoginSuccessModel? = nil, viewController:UIViewController){
        if let responseVal = loginModel{
            ZTAppSession.sharedInstance.setLoginInfo(data: responseVal)
            ZTAppSession.sharedInstance.setAccessToken(responseVal.token ?? "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Helper.shared.getUserBackground()
            }
            if responseVal.firstLogin?.lowercased() == FirstLogin.FirstLogin_YES.rawValue.lowercased(){
                ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
                self.goToSignupScreen(viewController: viewController)
            }else{
                ZTAppSession.sharedInstance.setIsUserLoggedIn(true)
                Helper.shared.goToHomeScreen()
            }
        }
    }
    
    func goToHomeScreen(){
        SwaggerClientAPI.customHeaders = WebServicesHelper.shared.getHeaderDetails()
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZT_TabbarController)
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [initial]
        mainNav = navigationController
        if let root = self.getWindow(){
            root.rootViewController = navigationController
        }
    }
    func goToLoginScreen(){
        SwaggerClientAPI.customHeaders = WebServicesHelper.shared.getHeaderDetails()
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTLoginViewController) as! ZTLoginViewController
        navigationController.viewControllers = [initial]
        if let root = self.getWindow(){
            root.rootViewController = navigationController
        }
    }
    func goToSignupRoot(){
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTSignupViewController) as! ZTSignupViewController
        navigationController.viewControllers = [initial]
        if let root = self.getWindow(){
            root.rootViewController = navigationController
        }
        
    }
    func goToSignupScreen(viewController:UIViewController){
        
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTSignupViewController) as! ZTSignupViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToVerificationScreen(viewController:UIViewController, enteredPhone:String, enteredDialCode:String, enteredEmail:String, isMobileFlow:Bool){
        
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTVerificationViewController) as! ZTVerificationViewController
        initial.enteredPhone = enteredPhone
        initial.enteredDialCode = enteredDialCode
        initial.enteredEmail = enteredEmail
        initial.isMobileFlow = isMobileFlow
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToMoviesCategoryListScreen(viewController:UIViewController, movieKey:String, collectionId:Int64? = -1, genreId:Int64? = -1, title:String? = ""){
        
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTMoviesListCategoryViewController) as! ZTMoviesListCategoryViewController
        initial.movieKey = movieKey
        initial.movieCollectionId = collectionId ?? -1
        initial.genreId = genreId ?? -1
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToMovieSearch(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTMovieSearchViewController) as! ZTMovieSearchViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToMovieDetails(viewController:UIViewController, movieInfo:Movies? = nil){
        
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTMovieDetailViewController) as! ZTMovieDetailViewController
        initial.moviewDetails = movieInfo
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToEditProfile(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTProfileEditViewController) as! ZTProfileEditViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToLanguage(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTLanguageViewController) as! ZTLanguageViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToMyTransactions(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTMyTransactionsViewController) as! ZTMyTransactionsViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToMyHelpAndSupport(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTHelpAndSupportViewController) as! ZTHelpAndSupportViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToSettings(viewController:UIViewController){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTSettingsViewController) as! ZTSettingsViewController
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToAbout(viewController:UIViewController, typeKey:String, titleValStr:String){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTAboutViewController) as! ZTAboutViewController
        initial.typeKey = typeKey
        initial.titleVal = titleValStr
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToChoosePlan(viewController:UIViewController, movieInfo:Movies? = nil){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTChooseAPlanViewController) as! ZTChooseAPlanViewController
        initial.moviewDetails = movieInfo
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToPaymentPage(viewController:UIViewController, subscriptionInfo:Subscriptions? = nil, movieInfo:Movies? = nil){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTPaymentsViewController) as! ZTPaymentsViewController
        initial.subscriptionInfo = subscriptionInfo
        initial.moviewDetails = movieInfo
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func goToRatingsReviews(viewController:UIViewController, movieInfo:Movies? = nil){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTRatingsReviewsViewController) as! ZTRatingsReviewsViewController
        initial.moviewDetails = movieInfo
        viewController.navigationController?.pushViewController(initial, animated: true)
    }
    func gotoWriteAReview(viewController:UIViewController, movieInfo:Movies? = nil){
        let storyboard = UIStoryboard(name: ZTStoryBoardName.MAIN, bundle: nil)
        let initial = storyboard.instantiateViewController(withIdentifier: ZTControllerName.ZTWriteAReviewViewController) as! ZTWriteAReviewViewController
        initial.modalPresentationStyle = .overCurrentContext
        initial.moviewDetails = movieInfo
        viewController.present(initial, animated: false, completion: nil)
    }
}
extension Helper:dataMissingDelegate{
    func showNoView(title:String, description:String, fromView:UIView, hideActionBtn:Bool, imageName:String, fromViewController:UIViewController, needToSetTop:Bool? = false){
           
        self.noRecordsView = Bundle.main.loadNibNamed("NoRecordsView", owner: self, options: nil)?[0] as! NoRecordsView
        self.helperDelegate = fromViewController as? HelperMethodsDelegate
        var frame = fromView.bounds
                      frame.origin.y = 0
                      self.noRecordsView.frame = frame
                      self.noRecordsView.tag = 100001
//        if needToSetTop == true{
//            self.noRecordsView.mainViewTopConstraints.constant = -(fromView.bounds.height / 3)
//        }
        self.noRecordsView.hideAllViews()
//        if imageName.count > 0{
//            self.noRecordsView.placeholderImageView.isHidden = false
//            self.noRecordsView.placeholderImageView.image = UIImage.init(named: imageName)
//        }
        
//        if title.count > 0{
//            self.noRecordsView.titleLabel.isHidden = false
//            self.noRecordsView.titleLabel.text = title
//
//        }
//        if description.count > 0{
//                   self.noRecordsView.descLabel.isHidden = false
//                   self.noRecordsView.descLabel.text = description
//
//               }
//        if hideActionBtn == false{
//            self.noRecordsView.vwBtns.isHidden = false
//        }
//
                  self.noRecordsView.btnDelegate = self
                      fromView.addSubview(self.noRecordsView)
                      
                  }
    func actionBtnTapped(_ sender: UIButton) {
        helperDelegate.missingDataActionTapped()
       }
    func removeNoView(fromView: UIView) {
            for view in fromView.subviews {
                if view.tag == 100001 {
                    view.removeFromSuperview()
                }
            }
    }
}
extension Double {
    
//    10000.asString(style: .positional)  // 2:46:40
//    10000.asString(style: .abbreviated) // 2h 46m 40s
//    10000.asString(style: .short)       // 2 hr, 46 min, 40 sec
//    10000.asString(style: .full)        // 2 hours, 46 minutes, 40 seconds
//    10000.asString(style: .spellOut)    // two hours, forty-six minutes, forty seconds
//    10000.asString(style: .brief)       // 2hr 46min 40sec
    
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}
extension UIView {
    func takeScreenshot() {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        screenShotImage = image
        UIGraphicsEndImageContext()
    }
}
