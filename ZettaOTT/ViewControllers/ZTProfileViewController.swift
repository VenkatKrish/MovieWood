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
    var headerHeight : CGFloat = 396
    var footerHeight : CGFloat = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
        }
        NotificationCenter.default.addObserver(self, selector: #selector(pageRefresh(_:)), name: NSNotification.Name(rawValue: TOKEN_EXPIRED), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view.takeScreenshot()
        NotificationCenter.default.removeObserver(self, name: Notification.Name(TOKEN_EXPIRED), object: nil)
    }
    @objc func pageRefresh(_ notification:NSNotification){
        self.pageNumber = 0
        self.initialLoad()
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
    func initialLoad(){
        self.getMyWatchLists(isSpinnerNeeded: true)
    }
    func registerCells(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        layout.collectionView?.backgroundColor = UIColor.getColor(colorVal: ZTBackgroundColor)
        self.profileCollection.addSubview(self.refreshControl)
        self.profileCollection.alwaysBounceVertical = true
        self.profileCollection.collectionViewLayout = layout
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
        if self.watchLists?.count ?? 0 > 0{
            return self.watchLists?.count ?? 0
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
        if self.watchLists?.count ?? 0 > 0{
            cell.loadMoviesModel(data: self.watchLists?[indexPath.row], indexPath: indexPath)
            return cell
        }else{
            Helper.shared.showNoView(fromView: cell, fromViewController: self, needToSetTop: true)
            return cell
        }
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
               let width = collectionView.frame.width - 32
                let widthPerItem = width / 3 - lay.minimumInteritemSpacing
               
        if self.watchLists?.count ?? 0 > 0{
            return CGSize(width: widthPerItem, height: widthPerItem + 50)
    
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - (self.headerHeight + 50))
        }
                
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.watchLists?.count ?? 0 > 0{
            if let movieInfo = self.watchLists?[indexPath.row]{
                Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileHeader, for: indexPath) as! ZTProfileHeader
                reusableview.loadProfileDetails(data: ZTAppSession.sharedInstance.getUserInfo())
            return reusableview
        }else{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter, for: indexPath) as! ZTProfileFooter
                return reusableview
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:self.footerHeight)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.headerHeight)
        }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.watchLists?.count ?? 0 > 0{
            if self.isPageEnable == true {
                if  indexPath.row ==  (self.watchLists?.count ?? 0) - 1{
                    self.pageNumber = self.pageNumber + 1
                    self.getMyWatchLists(isSpinnerNeeded: false)
                }
            }
        }
       }

}

extension ZTProfileViewController{
    func getMyWatchLists(isSpinnerNeeded:Bool){
        /*if NetworkReachability.shared.isReachable{
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.getWatchListUsingGET( pageNumber: self.pageNumber, pageSize: self.pageSize, completion: { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
         DispatchQueue.main.async {
             if self.refreshControl.isRefreshing{
                 self.refreshControl.endRefreshing()
             }
         }
//            Helper.shared.removeNoView(fromView: self.profileCollection)

                if self.pageNumber == 0{
                    self.watchLists?.removeAll()
                }
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
            })
        }
*/
        
                if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.zettaMovieOriginal.rawValue, page: 0, size: 100) { (response, error) in
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing{
                        self.refreshControl.endRefreshing()
                    }
                }
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
}
