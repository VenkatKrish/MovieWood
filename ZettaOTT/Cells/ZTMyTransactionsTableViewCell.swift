//
//  ZTMyTransactionsTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTMyTransactionsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var imgVwThumbnail: UIImageView!
    @IBOutlet weak var lblMoviePrice: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var lblTransactionDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadOrderDetails(data:Orders? = nil, indexPath:IndexPath){
        if let movieInfo = data?.orderMovie{
            self.lblMovieName.text = movieInfo.movieName
            self.lblMovieLanguage.text = movieInfo.primaryLanguage
            if let movieTime = movieInfo.runningTime{
               let convertToSec = Double(movieTime * 60)
                let stringVal = convertToSec.asString(style: .short)
                self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
            }
            self.lblMovieYear.text = String(format: "%d", Int(movieInfo.yearReleased ?? 0))
            self.lblMoviePrice.text = String(format: "%@", (movieInfo.iosTicketPrice ?? 0).getPriceValue())
            
            self.lblPaymentStatus.text = String(format: "%@", data?.paymentStatus ?? "")

            self.lblTransactionDate.text = String(format: "%@", data?.orderDate ?? "")

            Helper.shared.loadImage(url: movieInfo.image ?? "", imageView: self.imgVwThumbnail)
            
        }
    }
}
