//
//  ZTMovieInfo1ViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

struct LoadGenresType {
    var isSelected:Bool = false
    var genreVal:Genres? = nil
}
class ZTMovieInfo1ViewController: UIViewController {
    var allGenres : [LoadGenresType]? = []
    @IBOutlet weak var genreCollection: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.genreCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell)
        self.getGenrieList()
        // Do any additional setup after loading the view.
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
extension ZTMovieInfo1ViewController{
    func getGenrieList(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.genresUsingGET(offset: nil, pageNumber: 0, pageSize: 100, paged: nil, sortSorted: true, sortUnsorted: nil, unpaged: nil) { (response, error) in
                self.allGenres?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                      
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    if responseVal.content?.count ?? 0 > 0{
                        for i in responseVal.content ?? []{
                            self.allGenres?.append(LoadGenresType(isSelected: false, genreVal: i))
                        }
                        DispatchQueue.main.async {
                            self.genreCollection.reloadData()
                        }
                    }
                }
            }
        }
    }
}
extension ZTMovieInfo1ViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allGenres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, for: indexPath) as! ZTMovieInfoGenreCollectionViewCell
        
        cell.loadGenreDetails(data: self.allGenres?[indexPath.row], indexPath: indexPath)
        
        return cell
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//     inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
}
extension ZTMovieInfo1ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 2.0
        
    return CGSize(width: yourWidth - 5, height: 50)

        
    }
}
