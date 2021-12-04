//
//  ZTPortraitVideoCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTPortraitVideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVideoThumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVideoThumbnail.backgroundColor = .clear
        // Initialization code
    }
    func loadPortraitVideos(data:Movies? = nil){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVideoThumbnail )
        }
    }
}
