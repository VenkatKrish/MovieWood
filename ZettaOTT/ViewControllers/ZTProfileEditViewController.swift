//
//  ZTProfileEditViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit
import JVFloatLabeledTextField
import FlagPhoneNumber

class ZTProfileEditViewController: UIViewController {

    var isPhoneNumberValid: Bool = true
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    @IBOutlet weak var imgVwProfile: ZTCircularImageView!
    @IBOutlet weak var txtFieldFirstName: ZTCustomTextField!
    @IBOutlet weak var txtFieldLastName: ZTCustomTextField!
    @IBOutlet weak var txtFieldPhone: ZTPhoneCustomTextField!
    @IBOutlet weak var txtFieldEmail: ZTCustomTextField!
    @IBOutlet weak var txtFieldGender: ZTCustomTextField!
    @IBOutlet weak var txtFieldDOB: ZTCustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.setupPhoneTextField()
        if let user = ZTAppSession.sharedInstance.getUserInfo() {
            self.loadProfileDetails(data: user)
        }
    }
    func loadProfileDetails(data:AppUserModel? = nil){
        if let dataVal = data{
            if let name = dataVal.firstName, name.count > 0{
                self.txtFieldFirstName.text = String(format: "%@", dataVal.firstName ?? "")
            }
            if let name = dataVal.lastName, name.count > 0{
                self.txtFieldLastName.text = String(format: "%@", dataVal.lastName ?? "")
            }
            if let age = dataVal.age{
                self.txtFieldDOB.text = String(format: "%d",age)
            }
            if let gender = dataVal.gender, gender.count > 0{
                self.txtFieldDOB.text = String(format: "%@",gender)
            }
            if let mobile = dataVal.mobile{
                self.txtFieldPhone.text = String(format: "%@ %d",dataVal.countryCode ?? "", mobile)
            }
            if let userImagePath = dataVal.userImagePath, userImagePath.count > 0{
                Helper.shared.loadImage(url: userImagePath, imageView: self.imgVwProfile, placeHolder: ZTDefaultValues.placeholder_profile)
            }
        }
    }
    @IBAction func btnChangeProfileImage(_ sender: UIButton) {
        
    }
    @IBAction func btnSaveAndContinue(_ sender: UIButton) {
        if isValidationSuccess() == true{
            let firstName = self.removeWhiteSpace(text: self.txtFieldFirstName.text ?? "")
            let lastName = self.removeWhiteSpace(text: self.txtFieldLastName.text ?? "")
            let phoneNum = self.txtFieldPhone.getRawPhoneNumber() ?? "0"
            let dialCode = self.removeSpecialCharsFromPhoneString(text: self.txtFieldPhone.selectedCountry?.phoneCode ?? "91")
            let email = self.removeWhiteSpace(text: self.txtFieldEmail.text ?? "")

            let age = self.removeWhiteSpace(text: self.txtFieldDOB.text ?? "-1")

            let gender = self.removeWhiteSpace(text: self.txtFieldGender.text ?? "-1")
            if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
                self.updateProfile(firstName: firstName, lastName: lastName, email: email, mobile: phoneNum, dialCode: dialCode, age: Int64(age) ?? -1, userId: Int64(userModel.userId ?? -1), gender:gender)
            }
            
            
        }
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func isValidationSuccess() -> Bool {
        
        self.view.endEditing(true)
        var isValidationSuccess = true
        var message = ""
        
        if self.removeWhiteSpace(text: self.txtFieldEmail.text ?? "").count > 0{
            if Helper.shared.isValidEmailAddress(strValue: self.removeWhiteSpace(text: self.txtFieldEmail.text ?? "")) == false{
                message = ZTValidationMessage.INVALID_EMAIL
                isValidationSuccess = false
                self.txtFieldEmail.showError()
            }
        }
        if self.removeWhiteSpace(text: self.txtFieldPhone.text ?? "").count > 0{
            if self.isPhoneNumberValid == false{
                message = ZTValidationMessage.INVALID_PHONE_NUMBER
                isValidationSuccess = false
                self.txtFieldPhone.showError()
            }
        }
        return isValidationSuccess
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
extension ZTProfileEditViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringVal = NSString(string: textField.text!)
        let newText = stringVal.replacingCharacters(in: range, with: string)
        if newText.count >= 1{
            (textField as? ZTCustomTextField)?.removeError()
        }
        
        if textField == self.txtFieldFirstName {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.FIRST_NAME_MAX)
            }else{
                return false
            }
        }
        if textField == self.txtFieldLastName {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.LAST_NAME_MAX)
            }else{
                return false
            }
        }
        if textField == self.txtFieldDOB {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.AGE_MAX)
            }else{
                return false
            }
        }
        
        if textField == self.txtFieldPhone{
                   let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
                   let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.PHONENO_MAX)
            }else{
                return false
            }
        }
        
        if textField == txtFieldEmail{
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
}
extension ZTProfileEditViewController : FPNTextFieldDelegate{
    func setupPhoneTextField(){
        var currentCountry = ""
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            currentCountry = countryCode
        }
        txtFieldPhone.delegate = self
        txtFieldPhone.displayMode = .picker
        txtFieldPhone.hasPhoneNumberExample = false
        txtFieldPhone.placeholder = "Mobile Number"
        txtFieldPhone.flagButtonSize = CGSize(width: 32, height: 32)

        listController.setup(repository: txtFieldPhone.countryRepository)
       
        self.txtFieldPhone.setFlag(countryCode: FPNCountryCode(rawValue: currentCountry) ?? .IN)

        listController.didSelect = { [weak self] country in
            self?.txtFieldPhone.setFlag(countryCode: country.code)
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
//API methods
extension ZTProfileEditViewController{
    func updateProfile(firstName:String, lastName:String, email:String, mobile:String, dialCode:String, age:Int64, userId:Int64, gender:String){
        if NetworkReachability.shared.isReachable {
            let mobileNum = Int64(mobile)
            self.showActivityIndicator(self.view)
            let updateUser = UpdateUser(active: nil, address1: nil, address2: nil, age: age, city: nil, country: nil, countryCode: dialCode, deviceToken: nil, district: nil, emailId: email, firstName: firstName, gender: gender, landmark: nil, lastName: lastName, latitude: nil, longitude: nil, mobile: mobileNum, pincode: nil, primeUser: nil, userState: nil, userTimezone: nil)
            UserControllerAPI.updateUserUsingPUT(user: updateUser, userId: userId) { response, error in
                
                self.hideActivityIndicator(self.view)
                
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let _ = response{
                    DispatchQueue.main.async {
                        Helper.shared.showSnackBarAlert(message: ZTValidationMessage.PROFILE_UPDATED, type: .Success, superView: self)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
