//
//  ZTMainMenuViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTMainMenuViewController: UIViewController {
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblDivider: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var vwDashboard: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDivider.layer.cornerRadius = 2.0
        self.lblDivider.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imgVw.image = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let screenImgVal = screenShotImage{
                self.imgVw.image = screenImgVal
            }
        }
        self.getUserInfo()
    }
    func getUserInfo(){
        Helper.shared.getUserWithCompletion { response, error in
            if error == nil{
                if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
                    if let name = userModel.firstName, name.count > 0{
                        self.lblFirstName.text = String(format: "%@ %@", name, userModel.lastName ?? "")
                    }
                    if let email = userModel.emailId{
                        self.lblEmail.text = String(format: "%@",email)
                    }
                    Helper.shared.loadImage(url: userModel.userImagePath ?? "", imageView: self.imgVwProfile, placeHolder: ZTDefaultValues.placeholder_profile)
                }
            }
        }
    }
    @IBAction func menuTapped(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:// Edit profile
            Helper.shared.goToEditProfile(viewController: self)
            break
        case 1: // language
//            Helper.shared.goToLanguage(viewController: self)
            break
        case 2: // My transaction
            Helper.shared.goToMyTransactions(viewController: self)
            break
        case 3: // Help and Support
            Helper.shared.goToMyHelpAndSupport(viewController: self)
            break
        case 4: // Settings
            Helper.shared.goToSettings(viewController: self)
            break
        case 5: // About
            Helper.shared.goToAbout(viewController: self, typeKey: WebViewStrings.about.rawValue, titleValStr: WebViewStrings.title_about.rawValue)
            break
        case 6: // Terms & Conditions
            Helper.shared.goToAbout(viewController: self, typeKey: WebViewStrings.terms.rawValue, titleValStr: WebViewStrings.title_terms.rawValue)
            break
        case 7: // Privacy Policy
            Helper.shared.goToAbout(viewController: self, typeKey: WebViewStrings.privacy.rawValue, titleValStr: WebViewStrings.title_privacy.rawValue)
            break
        case 8:
            Helper.shared.showAlertDialog(title: AlertTitle.logoutTitle, subtitle: AlertDescrition.logoutDesc, type: .Logout, okButtonTitle: AlertButtons.YES, cancelButtonTitle: AlertButtons.CANCEL)
            break
        case 9:// Dashboard
            Helper.shared.goToDashboard(viewController: self)
            break
        default:
            break
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
