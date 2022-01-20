//
//  ZTMovieInfo3ViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

class ZTMovieInfo3ViewController: UIViewController {
    var movieInfo: Movies? = nil
    @IBOutlet weak var txtFldName: ZTCustomTextField!
    @IBOutlet weak var txtFldSignature: ZTCustomTextField!
    @IBOutlet weak var txtFldPlace: ZTCustomTextField!
    @IBOutlet weak var txtFldDate: ZTCustomTextField!
    var isTermsAccept:Bool = false
    @IBOutlet weak var btnCheckBox: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFldDate.text = Helper.shared.getFormatedDate(dateVal: Date(), dateFormat: CustomDateFormatter.movieSubmitDate)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDoneTapped(_ sender: Any) {
        if isValidationSuccess() == true{
            _ = self.removeWhiteSpace(text: self.txtFldName.text ?? "")
            let place = self.txtFldPlace.text ?? ""
            let signature = self.removeWhiteSpace(text: self.txtFldSignature.text ?? "")
            let dateVal = self.removeWhiteSpace(text: self.txtFldDate.text ?? "")

            if let movieVal = movieInfo{
                self.movieInfo?.contactPlace = place
                self.movieInfo?.contactSignature = signature
                self.movieInfo?.contactSignDate = dateVal
                self.uploadMovie(movieValue:movieVal)
            }
            
        }
    }
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        let btn = sender as! UIButton
        if btn.isSelected == false{
            btn.isSelected = true
            self.isTermsAccept = true
        }else{
            btn.isSelected = false
            self.isTermsAccept = false
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
extension ZTMovieInfo3ViewController: UITextFieldDelegate{
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
        
//        if self.removeWhiteSpace(text: self.txtFldName.text ?? "").count == 0{
//            isValidationSuccess = false
//            self.txtFldName.showError()
//        }
        
        if self.removeWhiteSpace(text: self.txtFldPlace.text ?? "").count == 0{
            isValidationSuccess = false
            self.txtFldPlace.showError()
        }
        if self.isTermsAccept == false{
            Helper.shared.showSnackBarAlert(message: "Please accept declaration", type: .Failure, superView: self)
            isValidationSuccess = false
        }
        return isValidationSuccess
    }
}
extension ZTMovieInfo3ViewController{
    func uploadMovie(movieValue:Movies){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            MovieControllerAPI.saveMovieUsingPOST(movie: movieValue) { response, error in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        self.showToastMessage(message: message)
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let _ = response{
                    self.navigationController?.popToRootViewController(animated: true)
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
