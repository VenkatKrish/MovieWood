//  ZTContinueWatchingCell.swift
//  ZettaOTT
//  Created by augusta-imac6 on 08/10/21.

import UIKit

protocol ZTContinueWatchingDelegate{
    func selectedVideoModel(movieInfo:Movies, indexVal:Int)
}
class ZTContinueWatchingCell: UITableViewCell {
    var delegate: ZTContinueWatchingDelegate? = nil
    @IBOutlet weak var continueCollectionView: UICollectionView!
    var watchLists : [Movies] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadContinueWatching(videosVal:[Movies]? = [], delegateObj:ZTContinueWatchingDelegate){
        self.delegate = delegateObj
        self.continueCollectionView.register(UINib(nibName: ZTCellNameOrIdentifier.ZTContinueWatchingCollectionCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTContinueWatchingCollectionCell)
        
        self.watchLists = videosVal ?? []

        self.continueCollectionView.dataSource = self
        self.continueCollectionView.delegate = self
        DispatchQueue.main.async {
            self.continueCollectionView.reloadData()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension ZTContinueWatchingCell:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.watchLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selectedVideoModel(movieInfo: self.watchLists[indexPath.row], indexVal: indexPath.row)

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTContinueWatchingCollectionCell, for: indexPath) as! ZTContinueWatchingCollectionCell
        cell.loadVideos(data: self.watchLists[indexPath.row], indexPath: indexPath)
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
        return 10
    }
}
extension ZTContinueWatchingCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: collectionView.frame.height)
    }
}
