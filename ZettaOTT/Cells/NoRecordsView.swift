//
//  NoRecordsView.swift
//  UBIQUIFIT
//
//  Created by iMac Augusta on 8/13/18.
//  Copyright © 2018 Anand-iMac. All rights reserved.
//

import UIKit

protocol dataMissingDelegate {
    func actionBtnTapped(_ sender:UIButton)
}
class NoRecordsView: UIView {
    var btnDelegate : dataMissingDelegate!

    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func hideAllViews(){
//        self.titleLabel.isHidden = true
//        self.descLabel.isHidden = true
        
    }
    
}
