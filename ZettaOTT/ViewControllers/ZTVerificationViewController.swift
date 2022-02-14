//
//  ZTVerificationViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/10/21.
//

import UIKit
import Alamofire

class ZTVerificationViewController: UIViewController {
   
    var enteredPhone:String = ""
    var enteredDialCode:String = ""
    var enteredEmail:String = ""
    var otpText:String = ""
    var isMobileFlow:Bool = true

    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    var isValidateSuccess:Bool = false
//    let otpStackView = OTPStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsetup()
        // Do any additional setup after loading the view.
    }
    func initialsetup(){
        setupOtpView()
//        vwOtp.addSubview(self.otpStackView)
//        otpStackView.delegate = self
    }
    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 6
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.defaultBorderColor = UIColor.init(named: ZTOTPBorderColor)!
            self.otpTextFieldView.filledBorderColor = UIColor.init(named: ZTOTPBorderColor)!
            self.otpTextFieldView.cursorColor = UIColor.init(named: ZTOTPBorderColor)!
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 35
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
        }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if self.isValidateSuccess == true{
            var loginSource = LoginSource.emailFlow
            var userNameStr = self.enteredEmail

            if self.isMobileFlow == true{
                loginSource = LoginSource.mobileFlow
                userNameStr = self.enteredPhone
            }
            self.authenticateUserEmailPhoneFlow(loginSource: loginSource, password: self.otpText, username: userNameStr)
            
        }else{
            Helper.shared.showSnackBarAlert(message: ZTValidationMessage.INVALID_OTP, type: .Failure)
        }
    }
    
    @IBAction func btnResendTapped(_ sender: Any) {
        if self.isMobileFlow == true{
            self.forgotPasswordByPhone(dialCode: self.enteredDialCode, phoneNum: self.enteredPhone)
        }else{
            self.loginWithEmail(dialCode: enteredDialCode, phoneNum: enteredPhone, email: enteredEmail)
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
extension ZTVerificationViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("hasEntered: \(hasEntered)")

        isValidateSuccess = hasEntered
        return isValidateSuccess
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.otpText = otpString
    }
    
}

extension ZTVerificationViewController{
    
    func validateOTP(otp:String, phoneNumber:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let requestVal = ValidateOTPRequest(otp: Int64(otp), username: phoneNumber)
            UserControllerAPI.validatePhoneOTPUsingPOST(login: requestVal) { (response, error) in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        self.showToastMessage(message: message)
                    }, failureBlock: { (errorMsg) in
                    })
                    return
                }
                if let _ = response{
                    self.authenticateUserPhoneFlow(loginSource: LoginSource.mobileFlow, password: self.otpText, username: self.enteredPhone)
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
                            
                        }else{
                            self.showToastMessage(message: message)
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    return
                }
                if let _ = response{
                    
                }
            }
        }
    }
    
    func loginWithEmail(dialCode:String, phoneNum:String, email:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let emailRequest = EmailRequest(emailId: email)
            UserControllerAPI.forgotPasswordUsingPOST(emailRequest: emailRequest) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        if code == StatusCodeObj.forbidden.rawValue{
                            
                        }else{
                            self.showToastMessage(message: message)
                        }
                    }, failureBlock: { (errorMsg) in
                    })
                    
                }else{
                    
                }
            }
        }
    }
    func authenticateUserEmailPhoneFlow(loginSource:String, password:String, username:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let loginRequest = LoginRequest(firstName: "", loginSource: loginSource, password: password, username: username, countryCode: self.enteredDialCode)
            UserControllerAPI.authenticateUserUsingPOST(loginRequest: loginRequest) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        self.showToastMessage(message: message)
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
    func authenticateUserPhoneFlow(loginSource:String, password:String, username:String){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            let loginRequest = LoginRequest(firstName: "", loginSource: loginSource, password: password, username: username, countryCode: self.enteredDialCode)
            UserControllerAPI.authenticateUserUsingPOST(loginRequest: loginRequest) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        self.showToastMessage(message: message)
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
    func showToastMessage(message:String){
        DispatchQueue.main.async {
            Helper.shared.showSnackBarAlert(message: message, type: .Failure, superView: self)
        }
    }
}
