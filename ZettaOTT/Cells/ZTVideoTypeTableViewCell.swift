//
//  ZTVideoTypeTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/10/21.
//

import UIKit

protocol ZTSelectedGenresDelegate{
    func selectedGenreIndex(tagVal:Int)
    func selectedLanguageIndex(tagVal:Int)
}
class ZTVideoTypeTableViewCell: UITableViewCell {
    var delegate : ZTSelectedGenresDelegate?
    @IBOutlet weak var typesCollectionView: UICollectionView!
    var typesVideos : [Genres] = []
    var languageList : [Languages] = []

    var isLanguage:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadTopics(videosVal:[Genres]? = [], delegateVal:ZTSelectedGenresDelegate){
        self.isLanguage = false
        self.delegate = delegateVal
        self.typesCollectionView.register(UINib(nibName: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell)
        self.typesVideos = videosVal ?? []
        self.typesCollectionView.dataSource = self
        self.typesCollectionView.delegate = self
        self.typesCollectionView.reloadData()
    }
    func loadLanguages(videosVal:[Languages]? = [], delegateVal:ZTSelectedGenresDelegate){
        self.delegate = delegateVal
        self.isLanguage = true
        self.typesCollectionView.register(UINib(nibName: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell)
        self.languageList = videosVal ?? []
        self.typesCollectionView.dataSource = self
        self.typesCollectionView.delegate = self
        self.typesCollectionView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension ZTVideoTypeTableViewCell:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isLanguage == true{
            return self.languageList.count
        }else{
            return self.typesVideos.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isLanguage == true{
            delegate?.selectedLanguageIndex(tagVal: indexPath.row)
        }else{
            delegate?.selectedGenreIndex(tagVal: indexPath.row)

        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.isLanguage == true{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
            cell.loadLanguageData(data: self.languageList[indexPath.row], indexPath: indexPath)
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
            cell.loadData(data: self.typesVideos[indexPath.row], indexPath: indexPath)
            
            return cell
        }
        
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    
    
}
extension ZTVideoTypeTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var item : String = ""
        if self.isLanguage == true{
            item = self.languageList[indexPath.row].languageName ?? ""
        }else{
            item = self.typesVideos[indexPath.row].genreName ?? ""
        }
         
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let size = CGSize(width: 120, height: collectionView.frame.size.height)
        let estimatedFrame = NSString(string: item).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.setAppFontMedium(15.0)], context: nil)
        let attributes = [NSAttributedString.Key.font : UIFont.setAppFontMedium(15.0)]

        let yourLabelSize: CGSize = item.size(withAttributes:attributes )
            
        var width1 = yourLabelSize.width
        if width1 < 120 {
                width1 = 120
        }
        return CGSize(width: estimatedFrame.width + 20, height: collectionView.frame.size.height)
        
    }
}
