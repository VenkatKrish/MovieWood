//
//  ZTTickerConfirmationViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTTickerConfirmationViewController: UIViewController {
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblPayType: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblTransactionDate: UILabel!
    @IBOutlet weak var lblBookingDate: UILabel!
    @IBOutlet weak var lblBookingPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblTicketTitle : UILabel!
    @IBOutlet weak var lblPlanName : UILabel!
    @IBOutlet weak var stackViewMovieInfo : UIStackView!

    var subscriptionInfo:Subscriptions? = nil
    var moviewDetails : Movies? = nil
    var isSubscription: Bool = true
    var appUserModel:AppUserModel? = nil
    var orderConfirmPayment:OrderConfirmPayment? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
            self.appUserModel = userModel
        }
        if self.isSubscription == true{
            self.lblTitle.text = ZTConstants.subscription_confirmation
            self.lblTicketTitle.text = ZTConstants.subscription_payment_success

            self.stackViewMovieInfo.isHidden = true
            self.lblPlanName.isHidden = false
            self.lblMovieName.text = self.subscriptionInfo?.name ?? ""
            self.lblPlanName.text = self.subscriptionInfo?._description
        }else{
            if let movieInfo = self.moviewDetails{
                self.lblTitle.text = ZTConstants.ticket_confirmation
                self.lblTicketTitle.text = ZTConstants.ticket_payment_success

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
        }
        self.lblTotalAmount.text = String(format: "%@", (self.orderConfirmPayment?.paidAmount ?? 0).getPriceValue())
       
        self.lblBookingPrice.text = String(format: "%@", (self.orderConfirmPayment?.paidAmount ?? 0).getPriceValue())

        self.lblPayType.text = String(format: "%@", self.orderConfirmPayment?.paymentMode ?? "")
        let transDate = Helper.shared.getConvertFromToDate(dateStr: self.orderConfirmPayment?.paymentDate ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
        
        self.lblTransactionDate.text = String(format: "%@", transDate)
       
        let bookingDate = Helper.shared.getConvertFromToDate(dateStr: self.orderConfirmPayment?.paymentDate ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.ticketConfirmationDate)
        self.lblBookingDate.text = String(format: "%@", bookingDate)
        
        if self.orderConfirmPayment?.paymentStatus == MovieOrderStatusStruct.paid.rawValue{
            self.lblStatus.text = TransactionStatusStruct.Success.rawValue
            self.lblStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
        }else{
            self.lblStatus.text = TransactionStatusStruct.Failure.rawValue
            self.lblStatus.textColor = UIColor.getColor(colorVal: ZTFailureColor)
        }
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        for controller in self.navigationController?.viewControllers ?? []{
            if controller.isKind(of: ZTMovieDetailViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
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
