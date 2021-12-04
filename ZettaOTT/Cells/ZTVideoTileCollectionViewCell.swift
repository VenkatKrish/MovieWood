//
//  ZTVideoTileCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 09/10/21.
//

import UIKit

class ZTVideoTileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVwVideoThumb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgVwVideoThumb.backgroundColor = .clear
        // Initialization code
    }
    func loadMovieCollectionModel(data:MovieCollections? = nil, indexPath:IndexPath){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.movie?.image ?? "", imageView: self.imgVwVideoThumb)
        }
    }
    
    func loadMoviesModel(data:Movies? = nil, indexPath:IndexPath){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVwVideoThumb)
        }
    }
    func loadHomePageTopMenu(data:Movies? = nil, indexPath:IndexPath){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVwVideoThumb)
        }
    }
    func loadOtherPages(data:Movies? = nil, indexPath:IndexPath){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.image ?? "", imageView: self.imgVwVideoThumb)
        }
    }
}
