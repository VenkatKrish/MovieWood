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
    @IBOutlet weak var txtFieldFirstName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldLastName: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldPhone: FPNTextField!
    @IBOutlet weak var txtFieldEmail: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldGender: JVFloatLabeledTextField!
    @IBOutlet weak var txtFieldDOB: JVFloatLabeledTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
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
                Helper.shared.loadImage(url: userImagePath, imageView: self.imgVwProfile)
            }
        }
    }
    @IBAction func btnChangeProfileImage(_ sender: UIButton) {
    }
    @IBAction func btnSaveAndContinue(_ sender: UIButton) {
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
