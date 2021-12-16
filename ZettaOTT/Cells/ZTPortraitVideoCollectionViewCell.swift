//
//  ZTPortraitVideoCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTPortraitVideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVideoThumbnail: UIImageView!
    @IBOutlet weak var vwExclusive: UIView!
    @IBOutlet weak var lblExclusiveText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVideoThumbnail.backgroundColor = .clear
        // Initialization code
    }
    func loadPortraitVideos(data:Movies? = nil, isExclusiveHide:Bool){
        if let dataVal = data{
            self.vwExclusive.isHidden = isExclusiveHide
            self.lblExclusiveText.text = String(format: "%@ %@%@", dataVal.promoLabel ?? "", ZTDefaultValues.Rupee_Symbol, (dataVal.iosTicketPrice ?? 0).string1)
            
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVideoThumbnail )
        }
    }
}
