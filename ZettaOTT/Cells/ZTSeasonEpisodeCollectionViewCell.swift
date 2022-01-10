//
//  ZTSeasonEpisodeCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/01/22.
//

import UIKit
protocol BtnTappedDelegate{
    func btnTapped(tagNumVal:Int)
}

class ZTSeasonEpisodeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVwEpisode: ZTGradientImageView!
    @IBOutlet weak var lblEpisodeTitle: UILabel!
    var delegate : BtnTappedDelegate? = nil
    @IBOutlet weak var btnTap: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadEpisodes(data:MovieEpisodes? = nil, delegateVal:BtnTappedDelegate, indexPath:IndexPath){
        if let dataVal = data{
            self.delegate = delegateVal
            self.btnTap.tag = indexPath.row
            self.lblEpisodeTitle.text = dataVal.name ?? ""
            Helper.shared.loadImage(url: dataVal.thumbnail ?? "", imageView: self.imgVwEpisode, placeHolder: nil)
        }
    }
    @IBAction func btnTappedVideo(_ sender: UIButton) {
        delegate?.btnTapped(tagNumVal: sender.tag)
    }
}
