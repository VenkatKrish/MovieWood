//
//  ZTChannelListCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 14/02/22.
//

import UIKit
protocol btnChannelDelegate{
    func btnChannelTapped(btn:UIButton)
}
class ZTChannelListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblChannelName: UILabel!
    @IBOutlet weak var imgVwChannel: UIImageView!
    @IBOutlet weak var btnChannel: UIButton!
    var delegate : btnChannelDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadChannelDetails(data:Channels? = nil, indexPath:IndexPath, delegateVal:btnChannelDelegate){
        if let dataVal = data{
            self.lblChannelName.text = dataVal.channelName ?? ""
            btnChannel.tag = indexPath.row
            delegate = delegateVal
        }
    }
    @IBAction func btnChannelTapped(_ sender: UIButton) {
        delegate.btnChannelTapped(btn: sender)
    }
}
