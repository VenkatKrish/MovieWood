//
//  ZTSignupViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/10/21.
//

import UIKit
import FlagPhoneNumber

class ZTSignupViewController: UIViewController {
    @IBOutlet weak var txtFldFirstName: ZTCustomTextField!
    @IBOutlet weak var txtFldLastName: ZTCustomTextField!
    @IBOutlet weak var txtFldEmail: ZTCustomTextField!
    @IBOutlet weak var txtFldAge: ZTCustomTextField!
    @IBOutlet weak var txtFldMobile: ZTPhoneCustomTextField!
    var isPhoneNumberValid: Bool = true
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var dialCode: String? = ""
    var phoneNumber: String? = ""
    var emailVal: String? = ""
    var userId: Int64? = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPhoneTextField()
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
            self.loadValues(userModel: userModel)
        }else{
            Helper.shared.getUserWithCompletion { response, error in
                self.loadValues(userModel: response)
            }
        }
        // Do any additional setup after loading the view.
    }
    func loadValues(userModel:AppUserModel? = nil){
        if let user = userModel{
            self.txtFldMobile.text = String(format: "%d", user.mobile ?? 0)
            let value = FPNCountryCode(rawValue: user.countryCode ?? ZTDefaultValues.defaultCountryCode)
            self.txtFldMobile.setFlag(countryCode: value!)
            self.txtFldEmail.text = user.emailId
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if isValidationSuccess() == true{
            
            let firstName = self.removeWhiteSpace(text: self.txtFldFirstName.text ?? "")
            let lastName = self.removeWhiteSpace(text: self.txtFldLastName.text ?? "")
            let phoneNum = self.txtFldMobile.getRawPhoneNumber() ?? "0"
            let dialCode = self.removeSpecialCharsFromPhoneString(text: self.txtFldMobile.selectedCountry?.phoneCode ?? "91")
            let email = self.removeWhiteSpace(text: self.txtFldEmail.text ?? "")

            let age = self.removeWhiteSpace(text: self.txtFldAge.text ?? "-1")

            self.updateProfile(firstName: firstName, lastName: lastName, email: email, mobile: phoneNum, dialCode: dialCode, age: Int64(age) ?? -1, userId: self.userId ?? -1)
        }
    }
}
extension ZTSignupViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringVal = NSString(string: textField.text!)
        let newText = stringVal.replacingCharacters(in: range, with: string)
        if newText.count >= 1{
            (textField as? ZTCustomTextField)?.removeError()
        }
        
        if textField == self.txtFldFirstName {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.FIRST_NAME_MAX)
            }else{
                return false
            }
        }
        if textField == self.txtFldLastName {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.LAST_NAME_MAX)
            }else{
                return false
            }
        }
        if textField == self.txtFldAge {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.AGE_MAX)
            }else{
                return false
            }
        }
        
        if textField == self.txtFldMobile{
                   let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
                   let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.PHONENO_MAX)
            }else{
                return false
            }
        }
        
        if textField == txtFldEmail{
            return newText.count <= Validation.EMAIL_MAX
        }
        if newText.containsEmoji{
            return false
        }
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){

        
    }
    func isValidationSuccess() -> Bool {
        
        self.view.endEditing(true)
        var isValidationSuccess = true
        var message = ""
        
        if self.removeWhiteSpace(text: self.txtFldFirstName.text ?? "").count == 0{
            message = ZTValidationMessage.FIRST_NAME_REQUIRED
            isValidationSuccess = false
            self.txtFldFirstName.showError()
        }
        
        if self.removeWhiteSpace(text: self.txtFldLastName.text ?? "").count == 0{
            message = ZTValidationMessage.LAST_NAME_REQUIRED
            isValidationSuccess = false
            self.txtFldLastName.showError()
        }
        if self.removeWhiteSpace(text: self.txtFldEmail.text ?? "").count == 0{
            message = ZTValidationMessage.EMAIL_REQUIRED
            isValidationSuccess = false
            self.txtFldEmail.showError()
        }
        if Helper.shared.isValidEmailAddress(strValue: self.removeWhiteSpace(text: self.txtFldEmail.text ?? "")) == false{
            message = ZTValidationMessage.INVALID_EMAIL
            isValidationSuccess = false
            self.txtFldEmail.showError()
        }
        if self.removeWhiteSpace(text: self.txtFldMobile.text ?? "").count == 0{
            message = ZTValidationMessage.MOBILE_NUMBER_REQUIRED
            isValidationSuccess = false
            self.txtFldMobile.showError()
        }
        if self.isPhoneNumberValid == false{
            message = ZTValidationMessage.INVALID_PHONE_NUMBER
            isValidationSuccess = false
            self.txtFldMobile.showError()
        }
        if self.removeWhiteSpace(text: self.txtFldAge.text ?? "").count == 0{
            message = ZTValidationMessage.AGE_REQUIRED
            isValidationSuccess = false
            self.txtFldAge.showError()
        }
        
        return isValidationSuccess
    }
}
extension ZTSignupViewController : FPNTextFieldDelegate{
    
    func setupPhoneTextField(){
        var currentCountry = ""
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            currentCountry = countryCode
        }
        txtFldMobile.delegate = self
        txtFldMobile.displayMode = .picker
        txtFldMobile.hasPhoneNumberExample = false
        txtFldMobile.placeholder = "Mobile Number*"
        txtFldMobile.flagButtonSize = CGSize(width: 32, height: 32)
        listController.setup(repository: txtFldMobile.countryRepository)
       
        
        self.txtFldMobile.setFlag(countryCode:.IN)

        listController.didSelect = { [weak self] country in
            self?.txtFldMobile.setFlag(countryCode: country.code)
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
       }

       /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
       func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isPhoneNumberValid = isValid

          if isValid {
          } else {
          }
       }
}
//API methods
extension ZTSignupViewController{
    func updateProfile(firstName:String, lastName:String, email:String, mobile:String, dialCode:String, age:Int64, userId:Int64){
        if NetworkReachability.shared.isReachable {
            let mobileNum = Int64(mobile)
            self.showActivityIndicator(self.view)
            let updateUser = UpdateUser(active: nil, address1: nil, address2: nil, age: age, city: nil, country: nil, countryCode: dialCode, deviceToken: nil, district: nil, emailId: email, firstName: firstName, gender: nil, landmark: nil, lastName: lastName, latitude: nil, longitude: nil, mobile: mobileNum, pincode: nil, primeUser: nil, userState: nil, userTimezone: nil)
            UserControllerAPI.updateUserUsingPUT(user: updateUser, userId: userId) { response, error in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        self.showToastMessage(message: message)
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let _ = response{
                    ZTAppSession.sharedInstance.setIsUserLoggedIn(true)
                    Helper.shared.goToHomeScreen()
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
