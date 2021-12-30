//
//  ZTFAQsTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 30/12/21.
//

import UIKit

protocol BtnArrowTappedDelegate{
    func btnTapped(tag:Int)
}
class ZTFAQsTableViewCell: UITableViewCell {
    var btnArrowTappedDelegate:BtnArrowTappedDelegate!
    @IBOutlet weak var lblFAQTitle : UILabel!
    @IBOutlet weak var lblFAQDescription : UILabel!
    @IBOutlet weak var btnArrow : UIButton!
    @IBOutlet weak var vwDescription : UIView!
    @IBOutlet weak var imgArrow : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadFAQs(data:FAQsStruct? = nil, indexPath:IndexPath, btnDelegate:BtnArrowTappedDelegate){
        if let dataVal = data{
            self.btnArrowTappedDelegate = btnDelegate
            self.lblFAQTitle.text = dataVal.faqModel?.title ?? ""
            self.lblFAQDescription.text = dataVal.faqModel?.text ?? ""
            self.btnArrow.tag = indexPath.row
            if dataVal.isSelected == true{
                self.imgArrow.image = UIImage(named: "arrow_up")
                self.vwDescription.isHidden = false
            }else{
                self.imgArrow.image = UIImage(named: "arrow_down")
                self.vwDescription.isHidden = true
            }
        }
    }
    @IBAction func btnArrowTapped(_ sender: UIButton) {
        btnArrowTappedDelegate.btnTapped(tag: sender.tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
