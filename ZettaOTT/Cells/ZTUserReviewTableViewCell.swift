//
//  ZTUserReviewTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTUserReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblReviewDate: UILabel!
    @IBOutlet weak var lblReviewsAvg: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgVwUser: ZTCircularImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadReviews(data:MovieReviews? = nil, indexPath:IndexPath){
        if let dataVal = data{
            self.lblUserName.text = dataVal.user?.firstName ?? ""
            self.lblReviewDate.text = "1d ago"
            self.lblDescription.text = dataVal.reviewComments ?? ""
            self.lblReviewsAvg.text = dataVal.rating ?? ""

            Helper.shared.loadImage(url: dataVal.user?.userImageName ?? "", imageView: self.imgVwUser, placeHolder: ZTDefaultValues.placeholder_profile)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
