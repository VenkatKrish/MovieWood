//
//  ZTProfileViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTProfileViewController: UIViewController {
    @IBOutlet weak var profileCollection: UICollectionView!
    var watchLists : [Movies]? = []
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    var isPageEnable: Bool = true
    var pageNumber : Int = 0
    var pageSize : Int = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.getMyWatchLists(isSpinnerNeeded: true)
    }
    func registerCells(){
        self.collectionWidth = (self.profileCollection.frame.size.width / 3) - 14
        
        self.collectionHeight = self.collectionWidth + 50
        
        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTProfileHeader, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileHeader)

        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTProfileFooter, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter)

        
        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
        
    }

}
//MARK: Collection View Methods

extension ZTProfileViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.watchLists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
        cell.loadMoviesModel(data: self.watchLists?[indexPath.row], indexPath: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.collectionWidth, height: self.collectionHeight)
       }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieInfo = self.watchLists?[indexPath.row]{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileHeader, for: indexPath) as! ZTProfileHeader
            if let user = ZTAppSession.sharedInstance.getUserInfo() {
                reusableview.loadProfileDetails(data: user)
            }
            return reusableview
        }else{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter, for: indexPath) as! ZTProfileFooter
                return reusableview
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:16)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 396)
        }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
               if self.isPageEnable == true {
                   if  indexPath.row ==  (self.watchLists?.count ?? 0) - 1{
                       self.pageNumber = self.pageNumber + 1
                       self.getMyWatchLists(isSpinnerNeeded: false)
                   }
               }
           
       }

}

extension ZTProfileViewController{
    func getMyWatchLists(isSpinnerNeeded:Bool){
//        if NetworkReachability.shared.isReachable{
//            if isSpinnerNeeded == true{
//                self.showActivityIndicator(self.view)
//            }
////            ZTCommonAPIWrapper.getWatchListUsingGET( pageNumber: self.pageNumber, pageSize: self.pageSize, completion: { response, error in
////                if isSpinnerNeeded == true{
////                    self.hideActivityIndicator(self.view)
////                }
        ///                Helper.shared.removeNoView(fromView: self.profileCollection)

////                if self.pageNumber == 0{
////                    self.watchLists?.removeAll()
////                }
////                if error != nil{
////                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
////
////                    }, failureBlock: { (errorMsg) in
////
////                    })
////                    return
////                }
////                if let responseVal = response{
//                    self.watchLists?.append(contentsOf: responseVal.content ?? [])
//    if responseVal.last == true{
//        self.isPageEnable  = false
//    }
////                    if self.watchLists?.count ?? 0 > 0{
////                        DispatchQueue.main.async {
////                            self.profileCollection.reloadData()
////                        }
////                    }else{
////                        Helper.shared.showNoView(title: "", description: "", fromView: self.profileCollection, hideActionBtn: true, imageName: "",fromViewController: self )
////                    }
////
////                }
////            })
////        }else{
////            self.hideActivityIndicator(self.view)
////        }
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.zettaMovieOriginal.rawValue, page: 0, size: 100) { (response, error) in
                if self.pageNumber == 0{
                    self.watchLists?.removeAll()
                }
                Helper.shared.removeNoView(fromView: self.profileCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.watchLists?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable  = false
                    }
                    if self.watchLists?.count ?? 0 > 0{
                    DispatchQueue.main.async {
                        self.profileCollection.reloadData()
                        }
                    }else{
                        Helper.shared.showNoView(title: "", description: "", fromView: self.profileCollection, hideActionBtn: true, imageName: "",fromViewController: self )
                    }
                }
            }
        }
    }
}
