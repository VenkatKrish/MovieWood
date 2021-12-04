//
//  ZTLoginViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 30/09/21.
//

import UIKit  //6806200
import FlagPhoneNumber
import GoogleSignIn
import FacebookLogin
import JVFloatLabeledTextField

class ZTLoginViewController: UIViewController {
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var txtFieldFlag: FPNTextField!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var vwEmail: UIView!
    
    

    var isOtherCountry : Bool = false
    var isPhoneNumberValid: Bool = true
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwEmail.isHidden = true
        self.setTapHereLabel()
        self.setupPhoneTextField()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLoginWithGmailTapped(_ sender: Any) {
        self.showActivityIndicator(self.view)
        let signInConfig = GIDConfiguration.init(clientID: SocialAccountInfo.Google_ClientId)

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            self.hideActivityIndicator(self.view)

            guard error == nil else { return }
            guard let user = user else { return }

            self.loginDetails(firstName: user.profile?.name ?? "", loginSource: LoginSource.gmailFlow, password: ZTDefaultValues.dummyPwd, username: user.profile?.email ?? "")
        }
    }
    @IBAction func btnSkipLogin(_ sender: Any) {
        ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
        ZTAppSession.sharedInstance.setAccessToken("")
        Helper.shared.goToHomeScreen()
    }
    @IBAction func btnLoginWithFBTapped(_ sender: Any) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            Profile.loadCurrentProfile { (profile, error) in
                if let profileVal = profile{
                    self.loginDetails(firstName: profileVal.firstName ?? "", loginSource: LoginSource.fbFlow, password: profileVal.userID, username: profileVal.email ?? "")
                }
            }
        } else {
            
            loginManager.logIn(permissions: ["public_profile", "email"], from: self) { [weak self] (result, error) in
                
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                Profile.loadCurrentProfile { (profile, error) in
                    if let profileVal = profile{
                        self?.loginDetails(firstName: profileVal.firstName ?? "", loginSource: LoginSource.fbFlow, password: profileVal.userID, username: profileVal.email ?? "")
                    }
                }
            }
        }
    }
    func loginDetails(firstName:String, loginSource:String, password:String, username:String){
        self.loginWithSocialAccount(firstName: firstName, loginSource: loginSource, password: password, username: username)
    }
    @IBAction func btnLoginTapped(_ sender: Any) {
        if self.isValidationSuccess(){
                let phoneNum = self.txtFieldFlag.getRawPhoneNumber() ?? "0"
                let dialCode = self.removeSpecialCharsFromPhoneString(text: self.txtFieldFlag.selectedCountry?.phoneCode ?? "91")
            let email = self.removeWhiteSpace(text: self.txtFieldEmail.text ?? "")
            
            if self.isOtherCountry == true{
                self.forgotPasswordByEmail(dialCode: dialCode, phoneNum: phoneNum, email: email)
            }else{
                self.forgotPasswordByPhone(dialCode: dialCode, phoneNum: phoneNum)

            }
        }
    }
    func setTapHereLabel(){
        let text = ZTConstants.termsLabel
        self.termsLabel.text = text
        self.termsLabel.textColor =  UIColor.init(named: ZTTermsColor)
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: ZTConstants.termsAndConditionLabel)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.setAppFontLight(12), range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: ZTTermsColor)!, range: range1)
        underlineAttriString.addAttribute(.underlineStyle,
                                           value: NSUnderlineStyle.single.rawValue,
                                           range: range1)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        underlineAttriString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, underlineAttriString.length))
        
        
        self.termsLabel.attributedText = underlineAttriString
        self.termsLabel.isUserInteractionEnabled = true
        self.termsLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let text = ZTConstants.termsLabel
        let termsRange = (text as NSString).range(of: ZTConstants.termsAndConditionLabel)
       
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            print("Tapped terms")

        } else {
            print("Tapped none")
        }
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


extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
       
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
   
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
extension ZTLoginViewController : FPNTextFieldDelegate{
    
    func setupPhoneTextField(){
        var currentCountry = ""
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            currentCountry = countryCode
        }
        txtFieldFlag.delegate = self
        txtFieldFlag.displayMode = .picker
        txtFieldFlag.hasPhoneNumberExample = false
        txtFieldFlag.placeholder = "Mobile Number"
        txtFieldFlag.flagButtonSize = CGSize(width: 32, height: 32)
        listController.setup(repository: txtFieldFlag.countryRepository)
       
        self.txtFieldFlag.setFlag(countryCode: FPNCountryCode(rawValue: currentCountry) ?? .IN)

        listController.didSelect = { [weak self] country in
            
            self?.txtFieldFlag.setFlag(countryCode: country.code)
        }
    }

       /// The place to present/push the listController if you choosen displayMode = .list
       func fpnDisplayCountryList() {
          let navigationViewController = UINavigationController(rootViewController: listController)
          
          present(navigationViewController, animated: true, completion: nil)
       }

       /// Lets you know when a country is selected
       func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
          print(name, dialCode, code) // Output "France", "+33", "FR"
           if code != FPNCountryCode.IN.rawValue{
               self.isOtherCountry = true
               self.vwEmail.isHidden = false
           }else{
               self.isOtherCountry = false
               self.vwEmail.isHidden = true
           }
       }

       /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
       func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isPhoneNumberValid = isValid

          if isValid {
             // Do something...
//             textField.getFormattedPhoneNumber(format: .E164)
//
//             textField.getFormattedPhoneNumber(format: .International)
//
//             textField.getFormattedPhoneNumber(format: .National)
//
//             textField.getFormattedPhoneNumber(format: .RFC3966)
//
//             textField.getRawPhoneNumber()
          } else {
             // Do something...
          }
       }
}
extension ZTLoginViewController {
    func isValidationSuccess() -> Bool {
        self.view.endEditing(true)
        var isValidationSuccess = true
        var message = ""
        if self.isOtherCountry == true{
            if removeWhiteSpace(text: txtFieldEmail.text ?? "").count == 0{
                message = ZTValidationMessage.EMAIL_REQUIRED
                isValidationSuccess = false
            }else if Helper.shared.isValidEmailAddress(strValue: removeWhiteSpace(text: txtFieldEmail.text ?? "")) == false{
                message = ZTValidationMessage.INVALID_EMAIL
                isValidationSuccess = false
            }
        }
        if removeWhiteSpace(text: txtFieldFlag.text ?? "").count == 0{
            message = ZTValidationMessage.MOBILE_NUMBER_REQUIRED
            isValidationSuccess = false
        }
        if (self.txtFieldFlag.text?.count ?? 0) > 0{
            if !isPhoneNumberValid{
                message = ZTValidationMessage.INVALID_PHONE_NUMBER
                isValidationSuccess = false
            }
        }
        
        if isValidationSuccess == false{
            Helper.shared.showSnackBarAlert(message: message, type: .Failure, superView: self)
        }
        return isValidationSuccess
    }
}
// API methods
extension ZTLoginViewController{
    func forgotPasswordByEmail(dialCode:String, phoneNum:String, email:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let emailRequest = EmailRequest(emailId: email)
            UserControllerAPI.forgotPasswordUsingPOST(emailRequest: emailRequest) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        if code == StatusCodeObj.forbidden.rawValue{
                            self.registerByEmail(email: email, dialCode: dialCode, phoneNum: phoneNum)
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    
                }else{
                    if let _ = response{
                        Helper.shared.goToVerificationScreen(viewController: self, enteredPhone: phoneNum, enteredDialCode: dialCode, enteredEmail: email, isMobileFlow: false)
                    }
                }
            }
        }
    }
    func forgotPasswordByPhone(dialCode:String, phoneNum:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let phoneRequest = PhoneRequest(countryCode: dialCode, mobileno: Int64(phoneNum))

            UserControllerAPI.forgotPasswordByPhoneUsingPOST(phoneRequest: phoneRequest) { (response, error) in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        if code == StatusCodeObj.forbidden.rawValue{
                            self.registerByPhone(dialCode: dialCode, phoneNum: phoneNum)
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    
                }else{
                    if let _ = response{
                        Helper.shared.goToVerificationScreen(viewController: self, enteredPhone: phoneNum, enteredDialCode: dialCode, enteredEmail: "", isMobileFlow: true)
                    }
                }
            }
        }
    }
    func registerByPhone(dialCode:String, phoneNum:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let registerByPhone = RegisterByPhone(countryCode: dialCode, mobileno: Int64(phoneNum))
            UserControllerAPI.registerUserByPhoneUsingPOST(user: registerByPhone) { (response, error) in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        if code == StatusCodeObj.forbidden.rawValue{
                            
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    return
                }
                if let _ = response{
                    self.forgotPasswordByPhone(dialCode: dialCode, phoneNum: phoneNum)
                }
            }
        }
    }
    func registerByEmail(email:String, dialCode:String, phoneNum:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let registerByEmail = RegisterByEmail(countryCode: dialCode, emailId: email, mobileno: Int64(phoneNum))
            UserControllerAPI.registerUserByEmailUsingPOST(user: registerByEmail) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        if code == StatusCodeObj.forbidden.rawValue{
                            
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    return
                }
                if let _ = response{
                    self.forgotPasswordByEmail(dialCode: dialCode, phoneNum: phoneNum, email: email)
                }
            }
        }
    }
    func loginWithSocialAccount(firstName:String, loginSource:String, password:String, username:String){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            let loginRequest = LoginRequest(firstName: firstName, loginSource: loginSource, password: password, username: username)
            UserControllerAPI.authenticateSocialUserUsingPOST(loginRequest: loginRequest) { (response, error) in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    Helper.shared.validateAfterLogin(loginModel: responseVal, viewController: self)
                }
            }
        }
    }
}
