//
//  ZTChannelMovieOrderTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/02/22.
//

import UIKit

class ZTChannelMovieOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDateDay: UILabel!
    @IBOutlet weak var lblDateMonth: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieStart: UILabel!
    @IBOutlet weak var lblMovieEnd: UILabel!
    @IBOutlet weak var lblMoviePrice: UILabel!
    @IBOutlet weak var lblPaymentStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadMovieDetails(dataVal:Movies? = nil, indexPath:IndexPath){
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
