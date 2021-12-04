//
//  ZTLanguageTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 04/12/21.
//

import UIKit

class ZTLanguageTableViewCell: UITableViewCell {
    @IBOutlet weak var lblLanguageName: UILabel!
    @IBOutlet weak var vwChecked: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
