//
//  ZTMovieInfoGenreCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

protocol btnCheckBoxDelegate{
    func btnCheckBoxTapped(btn:UIButton)
}
class ZTMovieInfoGenreCollectionViewCell: UICollectionViewCell {
    var delegate : btnCheckBoxDelegate? = nil
    @IBOutlet weak var lblGenreName: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var imgVwCheckBox: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadGenreDetails(data:LoadGenresType? = nil, indexPath:IndexPath, delegateVal:btnCheckBoxDelegate){
        self.delegate = delegateVal
        if let dataVal = data{
//            self.btnCheckBox.titleLabel?.text = ""
            self.lblGenreName.text = dataVal.genreVal?.genreName ?? ""
            if dataVal.isSelected == false{
                self.imgVwCheckBox.image = UIImage(named: "icon_unchecked")
            }else{
                self.imgVwCheckBox.image = UIImage(named: "icon_checked")
            }
            self.btnCheckBox.tag = indexPath.row
        }
    }
    @IBAction func btnCheckTapped(sender: UIButton) {
        self.delegate?.btnCheckBoxTapped(btn: sender)
    }

}
