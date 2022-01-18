//
//  ZTPaymentCardCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/12/21.
//

import UIKit

protocol btnProceedClickDelegate{
    func btnProceedClicked(btn:UIButton)
}

class ZTPaymentCardCollectionViewCell: UICollectionViewCell {
    var delegate:btnProceedClickDelegate? = nil
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblPlanPrice: UILabel!
    @IBOutlet weak var lblPlanDuration: UILabel!
    @IBOutlet weak var lblPlanDesc: UILabel!
    @IBOutlet weak var vwBorder: UIView!
    @IBOutlet weak var btnProceed: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadSubscriptionDetails(data:Subscriptions? = nil, indexPath:IndexPath, delegateVal:btnProceedClickDelegate){
        if let dataVal = data{
            self.delegate = delegateVal
            self.btnProceed.tag = indexPath.row
            let colorVal = Helper.shared.getRandomColor(indexVal: indexPath.row % colorRandom.count)
            self.lblPlanName.textColor = colorVal
            self.lblPlanName.text = dataVal.name ?? ""
            self.lblPlanDesc.text = dataVal._description ?? ""
            self.lblPlanDuration.text = String(format: "%d %@", dataVal.subDuration ?? 0, dataVal.uom ?? "")
            self.lblPlanPrice.text = String(format: "%@", (dataVal.subValue ?? 0).getPriceValue())
            
            self.vwBorder.applyGradientEffect(isVertical: false, colorVal: colorVal)

        }
    }
    @IBAction func btnProceedTapped(_ sender: UIButton) {
        delegate?.btnProceedClicked(btn: sender)
    }
}
