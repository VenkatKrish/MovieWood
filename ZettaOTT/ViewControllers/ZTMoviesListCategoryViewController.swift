//
//  ZTMoviesListCategoryViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 10/10/21.
//

import UIKit

class ZTMoviesListCategoryViewController: UIViewController {
   
    @IBOutlet weak var movieListCollection: UICollectionView!
    var videosList : [Movies]? = []
    var collectionsList : [MovieCollections]? = []
    var isPageEnable: Bool = true

    @IBOutlet weak var lblTitle: UILabel!
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    var movieKey : String = ""
    var searchKey : String = ""
    var pageNumber : Int = 0
    var pageSize : Int = 50
    var movieCollectionId : Int64 = -1
    var genreId : Int64 = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.searchKey = Helper.shared.getMovieSearchTag(movieTag: self.movieKey)
        self.lblTitle.text = self.movieKey
        self.pageNumber = 0
        self.initialLoad(isSpinnerNeeded: true)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionWidth = (self.movieListCollection.frame.size.width / 3) - 5
        
        self.collectionHeight = self.collectionWidth + 50
    }
    func initialLoad(isSpinnerNeeded:Bool){
        
        if self.pageNumber == 0{
            self.videosList?.removeAll()
        }
        if self.searchKey != ""{
            self.getMoviesList(isSpinnerNeeded:isSpinnerNeeded)
        }else if movieCollectionId != -1{
            self.getCollectionList(isSpinnerNeeded: isSpinnerNeeded)
        }else if genreId != -1{
            self.searchMoviesByGenreLang(ids: [genreId], langs: [], isSpinnerNeeded: isSpinnerNeeded)
        }
        
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        Helper.shared.goToMovieSearch(viewController: self)
    }
    func registerCells(){
        
        self.movieListCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
        
        
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
//MARK: Collection View Methods

extension ZTMoviesListCategoryViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.movieCollectionId != -1{
            return self.collectionsList?.count ?? 0
        }else {
            return self.videosList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell

        if self.movieCollectionId != -1{
            cell.loadMovieCollectionModel(data: self.collectionsList?[indexPath.row], indexPath: indexPath)
        }else{
            cell.loadMoviesModel(data: self.videosList?[indexPath.row], indexPath: indexPath)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.collectionWidth, height: self.collectionHeight)
       }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        
        if self.movieCollectionId != -1{
            if let movieModel = self.collectionsList?[indexPath.row].movie{
                Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieModel)
            }
        }else{
            if let movieModel = self.videosList?[indexPath.row]{
                Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieModel)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:16)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 1)
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.movieCollectionId != -1{
            if self.isPageEnable == true {
                if  indexPath.row ==  (self.collectionsList?.count ?? 0) - 1{
                    self.pageNumber = self.pageNumber + 1
                    self.initialLoad(isSpinnerNeeded: false)
                }
            }
        }else{
            if self.isPageEnable == true {
                if  indexPath.row ==  (self.videosList?.count ?? 0) - 1{
                    self.pageNumber = self.pageNumber + 1
                    self.initialLoad(isSpinnerNeeded: false)
                }
            }
        }
       }

}

extension ZTMoviesListCategoryViewController{
    func getMoviesList(isSpinnerNeeded:Bool){
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.searchMoviesGET(search: self.searchKey, page: self.pageNumber, size: self.pageSize) { (response, error) in
                if isSpinnerNeeded == true{
                DispatchQueue.main.async {
                self.hideActivityIndicator(self.view)
                }
                }
                Helper.shared.removeNoView(fromView: self.movieListCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.videosList?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }else{
                        self.isPageEnable = true
                    }
                    self.refreshUI()
                }
            }
        }
    }
    func refreshUI(){
        if self.videosList?.count ?? 0 > 0{
            DispatchQueue.main.async {
                self.movieListCollection.reloadData()
            }
        }else{
            Helper.shared.showNoView(title: "", description: "", fromView: self.movieListCollection, hideActionBtn: true, imageName: "",fromViewController: self )
        }
    }
    func searchMoviesByGenreLang(ids:[Int64] = [], langs:[Int64] = [], isSpinnerNeeded:Bool){
        var genreIds = ""
        if ids.count > 0{
            for (index, i) in ids.enumerated(){
                if index > 0{
                    genreIds = String(format: "%@;%d",genreIds,Int(i))
                }else{
                    genreIds = String(format: "%d", Int(i))
                }
            }
           
        }
        genreIds = String(format: "%@%@", MovieSearchTag.genresFilter.rawValue, genreIds)
        
        
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
            self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.searchMoviesGET(search: genreIds, page: self.pageNumber, size: self.pageSize) { (response, error) in
                if isSpinnerNeeded == true{

                DispatchQueue.main.async {
                self.hideActivityIndicator(self.view)
                }
                }
                Helper.shared.removeNoView(fromView: self.movieListCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.videosList?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }else{
                        self.isPageEnable = true
                    }
                    self.refreshUI()
                }
            }
        }
    }
    func getCollectionList(isSpinnerNeeded:Bool){
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.movieCollectionsById(_id: movieCollectionId, pageNumber: self.pageNumber, pageSize: self.pageSize) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
                Helper.shared.removeNoView(fromView: self.movieListCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.collectionsList?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }else{
                        self.isPageEnable = true
                    }
                    self.refreshUI()
                }
            }
        }
    }
}
