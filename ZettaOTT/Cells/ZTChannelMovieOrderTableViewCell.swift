//
//  ZTChannelMovieOrderTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/02/22.
//

import UIKit

protocol btnDetailsDelegate{
    func btnDetailsTapped(btn:UIButton)
}
class ZTChannelMovieOrderTableViewCell: UITableViewCell {
    var delegate:btnDetailsDelegate!
    @IBOutlet weak var lblDateDay: UILabel!
    @IBOutlet weak var lblDateMonth: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieStart: UILabel!
    @IBOutlet weak var lblMovieEnd: UILabel!
    @IBOutlet weak var lblMoviePrice: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var btnDetails: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadOrderDetails(dataVal:Orders? = nil, indexPath:IndexPath, delegateVal:btnDetailsDelegate, movieInfo:Movies? = nil){
        if let data = dataVal{
            self.delegate = delegateVal
            btnDetails.tag = indexPath.row
            self.lblDateDay.text = Helper.shared.getConvertFromToDate(dateStr: data.bookingStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDay)
            
            self.lblDateMonth.text = Helper.shared.getConvertFromToDate(dateStr: data.bookingStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionMonth)
            
            self.lblMovieStart.text = Helper.shared.getConvertFromToDate(dateStr: data.bookingStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
            
            self.lblMovieEnd.text = Helper.shared.getConvertFromToDate(dateStr: data.bookingEndTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
            
            
            self.lblMovieTitle.text = data.orderMovie?.movieName ?? ""
            self.lblMoviePrice.text = String(format: "%@", (data.paidAmount ?? 0).getPriceValue())
            
            if data.orderMovie?.paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }else if data.orderMovie?.paymentStatus == MoviePaymentStatusStruct.none.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Failure.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTFailureColor)
            }else{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }
        }
    }
    func loadMoviePlaysDetails(dataVal:MoviePlays? = nil, indexPath:IndexPath, delegateVal:btnDetailsDelegate, movieInfo:Movies? = nil){
        if let data = dataVal{
            self.delegate = delegateVal
            btnDetails.tag = indexPath.row
            self.lblDateDay.text = Helper.shared.getConvertFromToDate(dateStr: data.playStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDay)
            
            self.lblDateMonth.text = Helper.shared.getConvertFromToDate(dateStr: data.playStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionMonth)
            
            self.lblMovieStart.text = Helper.shared.getConvertFromToDate(dateStr: data.playStartTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
            
            self.lblMovieEnd.text = Helper.shared.getConvertFromToDate(dateStr: data.playEndTime ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDateWithTime)
            
            
            self.lblMovieTitle.text = movieInfo?.movieName ?? ""
            // commision
            var commission : Double = 0.0
            let duration = data.playDuration ?? 0

            if duration > 0{
                let val = (duration / 60) * (movieInfo?.subsCommission ?? 0)
                commission = Double(val)
            }
            self.lblMoviePrice.text = String(format: "%@", commission.getPriceValue())
            
            var minVal = "mins"
            if data.playDuration ?? 0 == 1{
                minVal = "min"
            }
            self.lblPaymentStatus.text = String(format: "%d %@", data.playDuration ?? 0, minVal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDetailsTapped(_ sender: UIButton) {
        delegate.btnDetailsTapped(btn: sender)
    }
}
