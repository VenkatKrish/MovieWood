//
//  ZTHomeTableViewCell.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

protocol ZTHomePageDelegate{
    func selectedVideoModel(movieInfo:Movies, indexVal:Int)
}
class ZTHomeTableViewCell: UITableViewCell {
    var delegate: ZTHomePageDelegate? = nil
    @IBOutlet weak var portraitCollection: UICollectionView!
    var portraintVideos : [Any] = []
    var isExclusiveHide: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.portraitCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell)
        // Initialization code
    }
    func loadPortraintVideos(videosVal:[Any]? = [], delegateObj:ZTHomePageDelegate, isExclusiveHide:Bool){
        self.delegate = delegateObj
        self.isExclusiveHide = isExclusiveHide
        self.portraintVideos = videosVal ?? []
        self.portraitCollection.dataSource = self
        self.portraitCollection.delegate = self
        DispatchQueue.main.async {
            self.portraitCollection.reloadData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension ZTHomeTableViewCell:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.portraintVideos.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfo = self.portraintVideos[indexPath.row]
        if movieInfo is Movies{
            let modelVal = movieInfo as! Movies
            self.delegate?.selectedVideoModel(movieInfo: modelVal, indexVal: indexPath.row)
        }else{
            let modelVal = movieInfo as! MovieCollections
            if let movieVal = modelVal.movie{
                self.delegate?.selectedVideoModel(movieInfo: movieVal, indexVal: indexPath.row)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, for: indexPath) as! ZTPortraitVideoCollectionViewCell
        let movieInfo = self.portraintVideos[indexPath.row]
        if movieInfo is Movies{
            let modelVal = movieInfo as! Movies
            cell.loadPortraitVideos(data: modelVal, isExclusiveHide: self.isExclusiveHide)

        }else{
            let modelVal = movieInfo as! MovieCollections
            if let movieVal = modelVal.movie{
                cell.loadPortraitVideos(data: movieVal, isExclusiveHide: self.isExclusiveHide)
            }
        }
        
        return cell
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
extension ZTHomeTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: collectionView.frame.size.height)
    }
}

