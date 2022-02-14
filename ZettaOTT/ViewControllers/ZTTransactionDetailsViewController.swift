//
//  ZTTickerConfirmationViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTTransactionDetailsViewController: UIViewController {
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblPayType: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
//    @IBOutlet weak var lblTransactionDate: UILabel!
    @IBOutlet weak var lblBookingDate: UILabel!
    @IBOutlet weak var lblBookingPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblTicketTitle : UILabel!
    @IBOutlet weak var lblPlanName : UILabel!
    @IBOutlet weak var stackViewMovieInfo : UIStackView!
    @IBOutlet weak var lblStartDate : UILabel!
    @IBOutlet weak var lblEndDate : UILabel!
    @IBOutlet weak var lblTransactionId : UILabel!
    @IBOutlet weak var lblBookingNo: UILabel!

    var appUserModel:AppUserModel? = nil
    var orderDetails:Orders? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
            self.appUserModel = userModel
        }
        if let movieInfo = self.orderDetails?.orderMovie{
            self.stackViewMovieInfo.isHidden = false
            self.lblPlanName.isHidden = true
            self.lblMovieName.text = movieInfo.movieName
            self.lblMovieLanguage.text = movieInfo.primaryLanguage
            if let movieTime = movieInfo.runningTime{
               let convertToSec = Double(movieTime * 60)
                let stringVal = convertToSec.asString(style: .short)
                self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
            }
            self.lblMovieAge.text = String(format: "%d+", Int(movieInfo.ageRating ?? 0))
            self.lblMovieYear.text = String(format: "%d", Int(movieInfo.yearReleased ?? 0))
        }
        self.lblTotalAmount.text = String(format: "%@", (self.orderDetails?.paidAmount ?? 0).getPriceValue())
       
        self.lblBookingPrice.text = String(format: "%@", (self.orderDetails?.paidAmount ?? 0).getPriceValue())

        self.lblPayType.text = String(format: "%@", self.orderDetails?.paymentMode ?? "")
        
        self.lblStartDate.text = Helper.shared.getConvertFromToDate(dateStr: self.orderDetails?.bookingStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
        
        self.lblEndDate.text = Helper.shared.getConvertFromToDate(dateStr: self.orderDetails?.bookingEndTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)

        
        self.lblTransactionId.text = self.orderDetails?.paymentTransactionNo ?? ""
        self.lblBookingNo.text = self.orderDetails?.orderNo ?? ""
        let bookingDate = Helper.shared.getConvertFromToDate(dateStr: self.orderDetails?.paymentDate ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.ticketConfirmationDate)
        
        self.lblBookingDate.text = String(format: "%@", bookingDate)
        
        
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
