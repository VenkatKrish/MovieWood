//
//  ZTMovieInfoGenreCollectionViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

protocol btnCheckBoxDelegate{
    func btnCheckBoxTapped(btn:UIButton)
    func btnCheckBoxFilterTapped(btn:UIButton, filterType:String)

}
class ZTMovieInfoGenreCollectionViewCell: UICollectionViewCell {
    var delegate : btnCheckBoxDelegate? = nil
    @IBOutlet weak var lblGenreName: UILabel!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var imgVwCheckBox: UIImageView!
    @IBOutlet weak var btnCheckBoxFilter: UIButton!
    var filterType:String = moviesKeyUI.col_title_genre
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadGenreDetails(data:LoadGenresType? = nil, indexPath:IndexPath, delegateVal:btnCheckBoxDelegate){
        self.btnCheckBoxFilter.isHidden = true
        self.btnCheckBox.isHidden = false
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
    func loadFilterGenreDetails(data:LoadGenresType? = nil, indexPath:IndexPath, delegateVal:btnCheckBoxDelegate){
        self.filterType = moviesKeyUI.col_title_genre
        self.btnCheckBoxFilter.isHidden = false
        self.btnCheckBox.isHidden = true
        self.delegate = delegateVal
        if let dataVal = data{
//            self.btnCheckBox.titleLabel?.text = ""
            self.lblGenreName.text = dataVal.genreVal?.genreName ?? ""
            if dataVal.isSelected == false{
                self.imgVwCheckBox.image = UIImage(named: "icon_unchecked")
            }else{
                self.imgVwCheckBox.image = UIImage(named: "icon_checked")
            }
            self.btnCheckBoxFilter.tag = indexPath.row
        }
    }
    func loadFilterLanguageDetails(data:LoadLanguageType? = nil, indexPath:IndexPath, delegateVal:btnCheckBoxDelegate){
        self.btnCheckBoxFilter.isHidden = false
        self.btnCheckBox.isHidden = true
        self.filterType = moviesKeyUI.col_title_languages
        self.delegate = delegateVal
        if let dataVal = data{
//            self.btnCheckBox.titleLabel?.text = ""
            self.lblGenreName.text = dataVal.langVal?.languageName ?? ""
            if dataVal.isSelected == false{
                self.imgVwCheckBox.image = UIImage(named: "icon_unchecked")
            }else{
                self.imgVwCheckBox.image = UIImage(named: "icon_checked")
            }
            self.btnCheckBoxFilter.tag = indexPath.row
        }
    }
    @IBAction func btnCheckTapped(sender: UIButton) {
        self.delegate?.btnCheckBoxTapped(btn: sender)
    }
    @IBAction func btnCheckBoxFilterTapped(sender: UIButton) {
        self.delegate?.btnCheckBoxFilterTapped(btn: sender, filterType: self.filterType)
    }

}
