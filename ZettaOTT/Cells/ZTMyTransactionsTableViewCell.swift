//
//  ZTMyTransactionsTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

protocol btnOrderMovieDelegate{
    func btnOrderTapped(btn:UIButton)
    func btnMovieTapped(btn:UIButton)
}
class ZTMyTransactionsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var imgVwThumbnail: UIImageView!
    @IBOutlet weak var lblMoviePrice: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblTransactionDate: UILabel!
    @IBOutlet weak var btnMovieDetails: UIButton!
    @IBOutlet weak var btnOrderDetails: UIButton!
    var delegate: btnOrderMovieDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnMovieTapped(_ sender: UIButton) {
        delegate.btnMovieTapped(btn: sender)
    }
    
    @IBAction func btnOrderTapped(_ sender: UIButton) {
        delegate.btnOrderTapped(btn: sender)
    }
    func loadOrderDetails(data:Orders? = nil, indexPath:IndexPath, delegateVal:btnOrderMovieDelegate){
            self.delegate = delegateVal
            self.lblMovieName.text = data?.orderMovie?.movieName
            self.lblMovieLanguage.text = data?.orderMovie?.primaryLanguage
            if let movieTime = data?.orderMovie?.runningTime{
               let convertToSec = Double(movieTime * 60)
                let stringVal = convertToSec.asString(style: .short)
                self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
            }
        self.btnMovieDetails.tag = indexPath.row
        self.btnOrderDetails.tag = indexPath.row
        self.lblMovieYear.text = String(format: "%d", Int(data?.orderMovie?.yearReleased ?? 0))
            self.lblMoviePrice.text = String(format: "%@", (data?.paidAmount ?? 0).getPriceValue())
            
            self.lblTransactionDate.text = Helper.shared.getConvertFromToDate(dateStr: data?.orderDate ?? "", fromDateFormat: CustomDateFormatter.orderRequestDate, toDateFormat: CustomDateFormatter.transactionDate)
            
            if data?.orderMovie?.paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }else if data?.orderMovie?.paymentStatus == MoviePaymentStatusStruct.none.rawValue{
                self.lblPaymentStatus.text = TransactionStatusStruct.Failure.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTFailureColor)
            }else{
                self.lblPaymentStatus.text = TransactionStatusStruct.Success.rawValue
                self.lblPaymentStatus.textColor = UIColor.getColor(colorVal: ZTSuccessColor)
            }
            
            Helper.shared.loadImage(url: data?.orderMovie?.thumbnail ?? "", imageView: self.imgVwThumbnail)
            
        
    }
}
