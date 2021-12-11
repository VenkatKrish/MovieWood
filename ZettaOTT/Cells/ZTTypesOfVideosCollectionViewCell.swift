//
//  TypesOfVideosCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTTypesOfVideosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.layer.cornerRadius = 5
        self.lblTitle.clipsToBounds = true
        // Initialization code
    }
    func loadData(data:Genres? = nil, indexPath:IndexPath){
        if let dataVal = data{
            
            self.lblTitle.backgroundColor = Helper.shared.getRandomColor(indexVal: indexPath.row % colorRandom.count)
            self.lblTitle.text = dataVal.genreName ?? ""
            self.lblTitle.font = UIFont.setAppFontRegular(13.0)
        }
    }
}
