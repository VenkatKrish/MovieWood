//
//  ZTPaymentCardCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/12/21.
//

import UIKit

class ZTPaymentCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblPlanPrice: UILabel!
    @IBOutlet weak var lblPlanDuration: UILabel!
    @IBOutlet weak var lblPlanDesc: UILabel!
    @IBOutlet weak var vwBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadSubscriptionDetails(data:Subscriptions? = nil, indexPath:IndexPath){
        if let dataVal = data{
            let colorVal = Helper.shared.getRandomColor(indexVal: indexPath.row % colorRandom.count)
            self.lblPlanName.textColor = colorVal
            self.lblPlanName.text = dataVal.name ?? ""
            self.lblPlanDesc.text = dataVal._description ?? ""
            self.lblPlanDuration.text = String(format: "%d %@", dataVal.subDuration ?? 0, dataVal.uom ?? "")
            self.lblPlanPrice.text = String(format: "%@", (dataVal.subValue ?? 0).getPriceValue())
            
            self.vwBorder.applyGradientEffect(isVertical: false, colorVal: colorVal)

        }
    }

}
