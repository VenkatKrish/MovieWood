//
//  ZTMovieInfo2ViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

class ZTMovieInfo2ViewController: UIViewController {
    @IBOutlet weak var txtFldName: ZTCustomTextField!
    @IBOutlet weak var txtFldEmail: ZTCustomTextField!
    @IBOutlet weak var txtFldMobile: ZTCustomTextField!
    var movieInfo: Movies? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        if isValidationSuccess() == true{
            let name = self.removeWhiteSpace(text: self.txtFldName.text ?? "")
            let phoneNum = self.txtFldMobile.text ?? ""
            let email = self.removeWhiteSpace(text: self.txtFldEmail.text ?? "")
            if let movieVal = movieInfo{
                self.movieInfo?.contactName = name
                self.movieInfo?.contactPhone = phoneNum
                self.movieInfo?.contactEmail = email
            }
            Helper.shared.gotoMovieInfo3(viewController: self, movieInfo:movieInfo)
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
extension ZTMovieInfo2ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringVal = NSString(string: textField.text!)
        let newText = stringVal.replacingCharacters(in: range, with: string)
        if newText.count >= 1{
            (textField as? ZTCustomTextField)?.removeError()
        }
        
        if textField == self.txtFldName {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS_NAME).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.FIRST_NAME_MAX)
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
        
        if self.removeWhiteSpace(text: self.txtFldName.text ?? "").count == 0{
            message = ZTValidationMessage.FIRST_NAME_REQUIRED
            isValidationSuccess = false
            self.txtFldName.showError()
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
        
        return isValidationSuccess
    }
}
