//
//  ZTSeasonEpisodeCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/01/22.
//

import UIKit


class ZTSeasonEpisodeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVwEpisode: ZTGradientImageView!
    @IBOutlet weak var lblEpisodeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadEpisodes(data:MovieEpisodes? = nil){
        if let dataVal = data{
            self.lblEpisodeTitle.text = dataVal.name ?? ""
            Helper.shared.loadImage(url: dataVal.thumbnail ?? "", imageView: self.imgVwEpisode, placeHolder: nil)
        }
    }
}
