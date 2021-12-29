//
//  ZTAboutViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit
import WebKit

class ZTAboutViewController: UIViewController {
    var typeKey : String = ""
    var titleVal : String = ""
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtVwContent: UITextView!
    @IBOutlet weak var lblVersion: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = titleVal
        self.getContentDetails(isSpinnerNeeded: true, seoUrl: self.typeKey)
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

extension ZTAboutViewController{
    func getContentDetails(isSpinnerNeeded:Bool, seoUrl:String){
        debugPrint("seoUrl\(seoUrl)")
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            PageControllerAPI.getPublicPageBySeoUrlUsingGET(seoUrl: seoUrl) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.txtVwContent.text = responseVal.pageContent ?? ""
                }
            }
        }
    }
}
