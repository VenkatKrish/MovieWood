//
//  ZTSeasonVideoListViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/01/22.
//

import UIKit

class ZTSeasonVideoListViewController: UIViewController {
    var portraintVideos : [MovieEpisodes] = []
    @IBOutlet weak var portraitCollection: UICollectionView!
    var pageNumber : Int = 0
    var pageSize : Int = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        self.portraitCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell)
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension ZTSeasonVideoListViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.portraintVideos.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfo = self.portraintVideos[indexPath.row]
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell, for: indexPath) as! ZTSeasonEpisodeCollectionViewCell
        let movieInfo = self.portraintVideos[indexPath.row]
        
        
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
extension ZTSeasonVideoListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: collectionView.frame.size.height)
    }
}

extension ZTSeasonVideoListViewController{
    func getMovieSeasons(isSpinnerNeeded:Bool){
        
    }
}
