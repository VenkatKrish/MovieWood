import UIKit

class ZTCustomAlertViewController: UIViewController {
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var titleText: String = ""
    var subTitle: String = ""
    var okButtonTitle: String = ""
    var cancelButtonTitle: String = ""
    var alertType: AlertViewType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
        titleLabel.text = titleText
        
        okButton.setTitle(okButtonTitle, for: .normal)
        
        if subTitle == ""{
            subtitleLabel.isHidden = true
        } else{
            subtitleLabel.isHidden = false
            subtitleLabel.text = subTitle
        }
        
        if cancelButtonTitle == ""{
            cancelButton.isHidden = true
        } else{
            cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
    }
    
    
    @IBAction func okButtonTapped(_ sender: Any) {
        switch self.alertType{
        case .CameraPermission:
            print("go to settings")
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
            self.dismiss(animated: true, completion: nil)
        
        case .Logout:
            ZTAppSession.sharedInstance.setAccessToken("")
            ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
            ZTAppSession.sharedInstance.removeAllInstance()
            Helper.shared.goToLoginScreen()
            
        case .SessionExpired:
            ZTAppSession.sharedInstance.setAccessToken("")
            ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
            ZTAppSession.sharedInstance.removeAllInstance()
            Helper.shared.goToLoginScreen()
        case .none:
            print("None")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        switch self.alertType{
        case .CameraPermission:
            print("go to settings")
            self.dismiss(animated: true, completion: {
                
            })
        case .Logout:
            self.dismiss(animated: true, completion: nil)
            
        case .SessionExpired:
            ZTAppSession.sharedInstance.setAccessToken("")
            ZTAppSession.sharedInstance.setIsUserLoggedIn(false)
            ZTAppSession.sharedInstance.removeAllInstance()
            Helper.shared.goToLoginScreen()
        case .none:
            print("None")
            self.dismiss(animated: true, completion: nil)
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
