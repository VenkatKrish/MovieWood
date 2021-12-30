//
//  ZTWebseriesViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/12/21.
//

import UIKit
import Alamofire
import SwiftUI
class ZTWebseriesViewController: UIViewController {
    @IBOutlet weak var profileCollection: UICollectionView!
    var streamingNowMovies : [Movies]? = []
    var webSeriesMovies : [Movies]? = []
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    var isPageEnable: Bool = true
    var pageNumber : Int = 0
    var pageSize : Int = 50
    var headerHeight : CGFloat = 265
    let spacing:CGFloat = 8.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.profileCollection.alwaysBounceVertical = true
        self.profileCollection.addSubview(self.refreshControl)
        self.calculateCollectionWidthHeight()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.getColor(colorVal: ZTGradientColor1)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.getColor(colorVal: ZTGradientColor1)]
        refreshControl.attributedTitle = NSAttributedString(string: ZTConstants.PLEASE_WAIT_LOADING, attributes: attributes)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pageNumber = 0
        self.initialLoad()
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
    func calculateCollectionWidthHeight(){
        
        
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
extension ZTWebseriesViewController{
    func getStreamingNowMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.streamNow(pageNumber: self.pageNumber, pageSize: self.pageSize, sortSorted: true, contenttype: MovieSearchTag.streamNowWebseries.rawValue) { (response, error) in
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing{
                        self.refreshControl.endRefreshing()
                    }
                }
                self.streamingNowMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.streamingNowMovies?.append(contentsOf: responseVal.content ?? [])
                    self.refreshTable()
                }
            }
        }
    }
    func refreshTable(){
        
        DispatchQueue.main.async {
            self.profileCollection.reloadData()
        }
        
    }
    func getWebSeriesVideos(isSpinnerNeeded:Bool){
            if NetworkReachability.shared.isReachable {
                if isSpinnerNeeded == true{
                    self.showActivityIndicator(self.view)
                }
                ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.webSeries.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                    if isSpinnerNeeded == true{
                        self.hideActivityIndicator(self.view)
                    }
                    if self.pageNumber == 0{
                        self.webSeriesMovies?.removeAll()
                    }
                    if error != nil{
                        WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in

                        }, failureBlock: { (errorMsg) in

                        })
                        return
                    }
                    if let responseVal = response, responseVal.content?.count ?? 0 > 0{
                        if responseVal.last == true{
                            self.isPageEnable = false
                        }
                        self.webSeriesMovies?.append(contentsOf: responseVal.content ?? [])
                        self.refreshTable()
                    }
                }
            }
        }
}
//MARK: Collection View Methods

extension ZTWebseriesViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.webSeriesMovies?.count ?? 0 > 0{
            return self.webSeriesMovies?.count ?? 0
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
        if self.webSeriesMovies?.count ?? 0 > 0{
            cell.loadMoviesModel(data: self.webSeriesMovies?[indexPath.row], indexPath: indexPath)
            return cell
        }else{
            Helper.shared.removeNoView(fromView: cell)
            Helper.shared.showNoView(fromView: cell, fromViewController: self, needToSetTop: true)
            return cell
        }
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
               
                let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
        if self.webSeriesMovies?.count ?? 0 > 0{
            return CGSize(width: widthPerItem, height: widthPerItem + 50)
    
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - (self.headerHeight + 50))
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.webSeriesMovies?.count ?? 0 > 0{
        if let movieInfo = self.webSeriesMovies?[indexPath.row]{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
        }
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
        if self.webSeriesMovies?.count ?? 0 > 0{
            if self.isPageEnable == true {
                if  indexPath.row ==  (self.webSeriesMovies?.count ?? 0) - 1{
                    self.pageNumber = self.pageNumber + 1
                    self.getWebSeriesVideos(isSpinnerNeeded: false)
                }
            }
        }
       }

}
extension ZTWebseriesViewController : ZTCollectionPagingDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
}
