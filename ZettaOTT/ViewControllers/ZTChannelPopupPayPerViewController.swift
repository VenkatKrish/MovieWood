//
//  ZTChannelPopupPayPerViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/02/22.
//

import UIKit

class ZTChannelPopupPayPerViewController: UIViewController {
    var orderInfo : Orders? = nil
    var playInfo : MoviePlays? = nil
    var movieInfo : Movies? = nil

    @IBOutlet weak var vwPayPerView: UIView!
    @IBOutlet weak var vwPlaysView: UIView!

    @IBOutlet weak var lblMovieStart: UILabel!
    @IBOutlet weak var lblMovieEnd: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!

    @IBOutlet weak var lblPlayStartTime: UILabel!
    @IBOutlet weak var lblPlayEndTime: UILabel!
    @IBOutlet weak var lblPlayDuration: UILabel!
    @IBOutlet weak var lblOperatingSystem: UILabel!
    @IBOutlet weak var lblShare: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func initialLoad(){
        self.vwPayPerView.isHidden = true
        self.vwPlaysView.isHidden = true
        if let dataVal = self.orderInfo{
            self.vwPayPerView.isHidden = false
            self.lblMovieStart.text = String(format: "Start : %@", Helper.shared.getConvertFromToDate(dateStr: dataVal.bookingStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime))
            
            self.lblMovieEnd.text = String(format: "End : %@", Helper.shared.getConvertFromToDate(dateStr: dataVal.bookingEndTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime))
            
            self.lblTotalAmount.text = String(format: "%@", (dataVal.paidAmount ?? 0).getPriceValue())
            
            if dataVal.orderMovie?.paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }else if dataVal.orderMovie?.paymentStatus == MoviePaymentStatusStruct.none.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Failure.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTFailureColor)
            }else{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }
        }
        
        if let dataVal = self.playInfo{
            self.vwPlaysView.isHidden = false

            self.lblPlayStartTime.text = String(format: "Start time : %@", Helper.shared.getConvertFromToDate(dateStr: dataVal.playStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime))
            
            self.lblPlayEndTime.text = String(format: "End time : %@", Helper.shared.getConvertFromToDate(dateStr: dataVal.playEndTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime))
            var minVal = "mins"
            if dataVal.playDuration ?? 0 == 1{
                minVal = "min"
            }
            self.lblPlayDuration.text = String(format: "%d %@", dataVal.playDuration ?? 0, minVal)
            
            // commision
            var commission : Double = 0.0
            let duration = dataVal.playDuration ?? 0

            if duration > 0{
                let val = (duration / 60) * (movieInfo?.subsCommission ?? 0)
                commission = Double(val)
            }
            self.lblShare.text = String(format: "%@", commission.getPriceValue())
        }
    }
}
