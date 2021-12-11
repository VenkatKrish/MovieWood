//
//  ZTShortFilmsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/12/21.
//

import UIKit
import Alamofire
import SwiftUI
class ZTShortFilmsViewController: UIViewController {
    @IBOutlet weak var profileCollection: UICollectionView!
    var streamingNowMovies : [Movies]? = []
    var webSeriesMovies : [Movies]? = []
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    var isPageEnable: Bool = true
    var pageNumber : Int = 0
    var pageSize : Int = 50
    var headerHeight : CGFloat = 265

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let _ = ZTAppSession.sharedInstance.getUserInfo(){
        }
    }

    func initialLoad(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.getStreamingNowMovies()
        self.getWebSeriesVideos(isSpinnerNeeded: true)
        }
    }
    
    func registerCells(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        self.profileCollection.collectionViewLayout = layout
        
        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPagingCollectionReusableView, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTPagingCollectionReusableView)

        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTProfileFooter, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter)

        
        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
    }
}
// API Methods
extension ZTShortFilmsViewController{
    func getStreamingNowMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.streamNow(pageNumber: self.pageNumber, pageSize: self.pageSize, sortSorted: true) { (response, error) in
                self.streamingNowMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.streamingNowMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.profileCollection.reloadData()
                    }
                }
            }
        }
    }
    func getWebSeriesVideos(isSpinnerNeeded:Bool){
        
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.zettaMovieOriginal.rawValue, page: 0, size: 100) { (response, error) in
                if self.pageNumber == 0{
                    self.webSeriesMovies?.removeAll()
                }
                Helper.shared.removeNoView(fromView: self.profileCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.webSeriesMovies?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable  = false
                    }
                    if self.webSeriesMovies?.count ?? 0 > 0{
                    DispatchQueue.main.async {
                        self.profileCollection.reloadData()
                        }
                    }
                }
            }
        }
        
//            if NetworkReachability.shared.isReachable {
//                if isSpinnerNeeded == true{
//                    self.showActivityIndicator(self.view)
//                }
//                ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.webSeries.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
//                    if isSpinnerNeeded == true{
//                        self.hideActivityIndicator(self.view)
//                    }
//                    if self.pageNumber == 0{
//                        self.webSeriesMovies?.removeAll()
//                    }
//                    if error != nil{
//                        WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
//
//                        }, failureBlock: { (errorMsg) in
//
//                        })
//                        return
//                    }
//                    if let responseVal = response, responseVal.content?.count ?? 0 > 0{
//                        if responseVal.last == true{
//                            self.isPageEnable = false
//                        }
//                        self.webSeriesMovies?.append(contentsOf: responseVal.content ?? [])
//                        DispatchQueue.main.async {
//                            self.profileCollection.reloadData()
//                        }
//                    }
//                }
//            }
        }
}
//MARK: Collection View Methods

extension ZTShortFilmsViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.webSeriesMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
        cell.loadMoviesModel(data: self.webSeriesMovies?[indexPath.row], indexPath: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
               
                let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
               
                return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieInfo = self.webSeriesMovies?[indexPath.row]{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ZTCellNameOrIdentifier.ZTPagingCollectionReusableView, for: indexPath) as! ZTPagingCollectionReusableView
            reusableview.loadPagingScroll(videosVal: self.streamingNowMovies ?? [], delegateObj: self)
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
        return CGSize(width: collectionView.frame.width, height: self.headerHeight)
        }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
               if self.isPageEnable == true {
                   if  indexPath.row ==  (self.webSeriesMovies?.count ?? 0) - 1{
                       self.pageNumber = self.pageNumber + 1
                       self.getWebSeriesVideos(isSpinnerNeeded: false)
                   }
               }
           
       }

}
extension ZTShortFilmsViewController : ZTCollectionPagingDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
}
