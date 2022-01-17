//
//  ZTCrewCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/11/21.
//

import UIKit

class ZTCrewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var imgVwProfile: ZTCircularImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadCastDetails(data:MovieActors? = nil){
        if let model = data{
            self.lblName.text = model.actor?.actorName ?? ""
            self.lblDesignation.text = model.actorRole ?? ""
            Helper.shared.loadImage(url: model.actor?.actorImage ?? "", imageView: self.imgVwProfile, placeHolder: ZTDefaultValues.placeholder_profile)
        }
        
    }
    func loadCrewDetails(data:MovieCrew? = nil){
        if let model = data{
            self.lblName.text = model.actor?.actorName ?? ""
            self.lblDesignation.text = model.crewRole ?? ""
            Helper.shared.loadImage(url: model.actor?.actorImage ?? "", imageView: self.imgVwProfile, placeHolder: ZTDefaultValues.placeholder_profile)
        }
        
    }

}
