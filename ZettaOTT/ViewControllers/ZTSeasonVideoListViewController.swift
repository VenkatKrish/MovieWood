//
//  ZTSeasonVideoListViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 08/01/22.
//

import UIKit

struct SeasonVideoStruct {
    var movieSeason:MovieSeasons?
    var movieEpisodes:MovieEpisodes?
}
class ZTSeasonVideoListViewController: UIViewController {
    var portraintVideos : [MovieEpisodes] = []
    var movieSeasons: [MovieSeasons]? = []
    var tagNum : Int = 0
    @IBOutlet weak var seasonCollection: UICollectionView!
    @IBOutlet weak var vwHeightConstraints: NSLayoutConstraint!
    var pageNumber : Int = 0
    var pageSize : Int = 50
    var viewHeight : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.vwHeightConstraints.constant = CGFloat(self.viewHeight)
        self.seasonCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell)
        
        self.initialLoad()
    }
    func initialLoad(){
        self.portraintVideos.removeAll()
        self.portraintVideos.append(contentsOf: self.movieSeasons?[tagNum].movieEpisodes ?? [])
        DispatchQueue.main.async {
            self.seasonCollection.reloadData()
        }
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
extension ZTSeasonVideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.portraintVideos.count

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfo = self.portraintVideos[indexPath.row]
        self.selectedEpisode(episode: movieInfo)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTSeasonEpisodeCollectionViewCell, for: indexPath) as! ZTSeasonEpisodeCollectionViewCell
        
        let movieInfo = self.portraintVideos[indexPath.row]
        cell.loadEpisodes(data: movieInfo, delegateVal: self, indexPath:indexPath)
        return cell
        
    }
    
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: collectionView.frame.size.height)
    }
    func selectedEpisode(episode:MovieEpisodes? = nil){
        if let val = episode{
            let seasonVideo = SeasonVideoStruct(movieSeason: self.movieSeasons?[tagNum], movieEpisodes: val)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: SEASON_VIDEO_SELECTION), object: seasonVideo, userInfo: nil)
        }
    }
}
extension ZTSeasonVideoListViewController:BtnTappedDelegate{
    func btnTapped(tagNumVal: Int) {
        let movieInfo = self.portraintVideos[tagNumVal]
        self.selectedEpisode(episode: movieInfo)
    }
}
