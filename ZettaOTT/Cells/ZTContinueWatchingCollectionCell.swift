//
//  ZTContinueWatchingCollectionCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/10/21.
//

import UIKit

class ZTContinueWatchingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgVwWatchList: UIImageView!
    @IBOutlet weak var taskProgress:UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func loadVideos(data:Movies? = nil, indexPath:IndexPath){
        if let dataVal = data{
            Helper.shared.loadImage(url: dataVal.thumbnail ?? "", imageView: self.imgVwWatchList)
            
        }
    }
}
