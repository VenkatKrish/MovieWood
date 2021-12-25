//
//  ZTMainMenuViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTMainMenuViewController: UIViewController {
    @IBOutlet weak var imgVw: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.imgVw.image = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let screenImgVal = screenShotImage{
                self.imgVw.image = screenImgVal
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
            Helper.shared.goToLanguage(viewController: self)
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
