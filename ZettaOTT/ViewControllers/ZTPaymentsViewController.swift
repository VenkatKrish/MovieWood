//
//  ZTPaymentsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTPaymentsViewController: UIViewController {
    var subscriptionInfo:Subscriptions? = nil
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var stackLanguageTime: UIStackView!
    @IBOutlet weak var lblPrice: UILabel!   
    var isSubscription: Bool = true
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    var moviewDetails : Movies? = nil
    @IBOutlet weak var lblSeperator: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        if self.isSubscription == true{
            self.stackLanguageTime.isHidden = true
//            self.lblSeperator.isHidden = true

            if let dataVal = subscriptionInfo{
                let duration:Int = Int(dataVal.subDuration ?? 0)
                self.lblPlanName.text = dataVal.name ?? ""
                self.lblDuration.text = String(format: "%d %@", duration, dataVal.uom ?? "")
                self.lblPrice.text = String(format: "%@%@", ZTDefaultValues.Rupee_Symbol, (dataVal.subValue ?? 0).string1)
            }
        }else{
            self.stackLanguageTime.isHidden = false
//            self.lblSeperator.isHidden = false
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPayment(_ sender: Any) {
        
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
