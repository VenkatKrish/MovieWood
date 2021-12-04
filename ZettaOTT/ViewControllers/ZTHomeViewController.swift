//
//  ZTHomeViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit
import Alamofire
import SwiftUI
class ZTHomeViewController: UIViewController {
    @IBOutlet weak var tblHome: UITableView!
    @IBOutlet weak var upcomingCollection: UICollectionView!
    @IBOutlet weak var webseriesCollection: UICollectionView!
    @IBOutlet weak var shortFilmsCollection: UICollectionView!
    @IBOutlet weak var vwUpcomingTable: UIView!
    @IBOutlet weak var vwWebseriesTable: UIView!
    @IBOutlet weak var vwShortFilmsTable: UIView!
    var movieCollectionsValues : [MCollections]? = []

    var upcomingMovies : [Movies]? = []
    var webSeriesMovies : [Movies]? = []
    var shortFilmsMovies : [Movies]? = []

    var streamingNowMovies : [Movies]? = []
    var zettaMovieOriginals : [Movies]? = []
    var continueWatching : [Movies]? = []
    var popularMovies : [Movies]? = []
    var allGenres : [Genres]? = []
    var allTitles = [moviesKeyUI.paging, moviesKeyUI.continue_watching, moviesKeyUI.genres, moviesKeyUI.zetta_movies_originals, moviesKeyUI.popular_movies]
    @IBOutlet weak var vwNew: UIView!
    @IBOutlet weak var vwUpcoming: UIView!
    @IBOutlet weak var vwWebseries: UIView!
    @IBOutlet weak var vwShortFilms: UIView!
    var pageSize : Int = 5
    var pageNumber : Int = 0
    
    var movieColPageSize : Int = 5
    var movieColPageNumber : Int = 0
    
    var collectionPageSize : Int = 50
    var collectionPageNumber : Int = 0
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    
    var isPageEnable: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.forceToSetStreaming()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
        }
    }
    func forceToSetStreaming(){
        self.hideAllViews()
        self.tblHome.isHidden = false
        self.tblHome.reloadData()
        self.resetTopMenuSeperator(view: self.vwNew)
    }
    func resetTopMenuSeperator(view:UIView? = nil){
       
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: { () -> Void in
                       
                        self.vwNew.backgroundColor = UIColor.clear
                        self.vwUpcoming.backgroundColor = UIColor.clear
                        self.vwWebseries.backgroundColor = UIColor.clear
                        self.vwShortFilms.backgroundColor = UIColor.clear
                        
                        if let viewVal = view{
                            viewVal.backgroundColor = UIColor.init(named: ZTTabbarSelectedColor)
                        }
                        
        }, completion: nil)
        
        
    }
    func initialLoad(){
        self.getStreamingNowMovies()
        if ZTAppSession.sharedInstance.getIsUserLoggedIn(){
            self.getContinueWatching()
        }
        self.getContinueWatching()
        self.getZettMoviesOriginals()
        self.getPopularMovies()
        self.getGenrieList()
        self.movieColPageNumber = 0
        self.getAllCollections(isSpinnerNeeded: true)
    }
    
    func registerCells(){
        
        self.tblHome.rowHeight = UITableView.automaticDimension

        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTHomeTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTHomeTableViewCell)
        
        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPagingTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTPagingTableViewCell)
        
        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTypeTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTypeTableViewCell)
        
        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTContinueWatchingCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTContinueWatchingCell)
        
        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoHeaderTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoHeaderTableViewCell)        
        
        self.tblHome.dataSource = self
        self.tblHome.delegate = self
        self.tblHome.reloadData()
        
        self.upcomingCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
        
        self.webseriesCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
        
        self.shortFilmsCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell)
        
        self.collectionWidth = (self.upcomingCollection.frame.size.width / 3)
        
        self.collectionHeight = self.collectionWidth + 50
        
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
extension ZTHomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keyVal = self.allTitles[section]
        if keyVal == moviesKeyUI.genres {
            if self.allGenres?.count ?? 0 > 0{
                return 1
            }
        }else if keyVal == moviesKeyUI.paging {
            if self.streamingNowMovies?.count ?? 0 > 0{
                return 1
            }
        }else if keyVal == moviesKeyUI.continue_watching {
            if self.continueWatching?.count ?? 0 > 0{
                return 1
            }
        }else if keyVal == moviesKeyUI.zetta_movies_originals {
            if self.zettaMovieOriginals?.count ?? 0 > 0{
                return 1
            }
        }else if keyVal == moviesKeyUI.popular_movies {
            if self.popularMovies?.count ?? 0 > 0{
                return 1
            }
        }else{
            if self.movieCollectionsValues?.count ?? 0 > 0{
                return 1
            }
            return 0
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keyVal = self.allTitles[indexPath.section]
        if keyVal == moviesKeyUI.genres {
            let cell: ZTVideoTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTVideoTypeTableViewCell, for: indexPath) as! ZTVideoTypeTableViewCell
            cell.loadTopics(videosVal: self.allGenres, delegateVal: self)
            return cell
        }else if keyVal == moviesKeyUI.paging {
            let cell: ZTPagingTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTPagingTableViewCell, for: indexPath) as! ZTPagingTableViewCell
            cell.loadPagingScroll(videosVal: self.streamingNowMovies ?? [], delegateObj: self)
            return cell
        }else if keyVal == moviesKeyUI.continue_watching {
            let cell: ZTContinueWatchingCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTContinueWatchingCell, for: indexPath) as! ZTContinueWatchingCell
            cell.loadContinueWatching(videosVal: self.continueWatching)
            return cell
        }else{
            let cell: ZTHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTHomeTableViewCell, for: indexPath) as! ZTHomeTableViewCell
            if keyVal == moviesKeyUI.zetta_movies_originals {
                cell.loadPortraintVideos(videosVal: self.zettaMovieOriginals, delegateObj: self)
                return cell
            }
            else if keyVal == moviesKeyUI.popular_movies {
                cell.loadPortraintVideos(videosVal: self.popularMovies, delegateObj: self)
                return cell
            }else{
                if self.movieCollectionsValues?.count ?? 0 > 0{
                    if let filterMovies = self.movieCollectionsValues?
                        .first(where: { $0.name == keyVal }), filterMovies.movieCollections?.count ?? 0 > 0{
                        cell.loadPortraintVideos(videosVal: filterMovies.movieCollections ?? [], delegateObj: self) // will change the model and array
                    }
                }
                return cell
            }
        }
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let keyVal = self.allTitles[section]
        let cellHeight:CGFloat = 45
        if keyVal == moviesKeyUI.genres || keyVal == moviesKeyUI.paging {
            return 0.1
        }else {
            if keyVal == moviesKeyUI.continue_watching {
                if self.continueWatching?.count ?? 0 > 0{
                    return cellHeight
                }else{
                    return 0.1
                }
            }else{
                return cellHeight
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let keyVal = self.allTitles[section]

        let headerView : ZTVideoHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTVideoHeaderTableViewCell) as! ZTVideoHeaderTableViewCell

        headerView.lblTitle.text = ""
        headerView.btnMore.isHidden = true
        headerView.btnMore.tag = section
        headerView.btnMore.addTarget(self, action: #selector(moreBtnTapped(sender:)), for: .touchUpInside)
        if keyVal == moviesKeyUI.paging || keyVal == moviesKeyUI.genres{
            headerView.lblTitle.text = ""
            headerView.btnMore.isHidden = true
        }else{
            if keyVal == moviesKeyUI.continue_watching {
                if self.continueWatching?.count ?? 0 > 0{
                    headerView.lblTitle.text = keyVal
                    headerView.btnMore.isHidden = false
                }
            }else{
                headerView.lblTitle.text = keyVal
                headerView.btnMore.isHidden = false
            }
        }

        return headerView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isPageEnable == true {
            if   indexPath.section ==  self.allTitles.count - 1 {
                debugPrint(indexPath.row)
                self.movieColPageNumber = self.movieColPageNumber + 1
                self.getAllCollections(isSpinnerNeeded: false)
            }
        }
    }

}

// IBAction Methods
extension ZTHomeViewController{
    @objc func moreBtnTapped(sender: UIButton){
        let keyVal = self.allTitles[sender.tag]
        
        if keyVal == moviesKeyUI.genres || keyVal == moviesKeyUI.paging || keyVal == moviesKeyUI.continue_watching || keyVal == moviesKeyUI.zetta_movies_originals || keyVal == moviesKeyUI.popular_movies || keyVal == moviesKeyUI.popular_movies{
            Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: keyVal)
        }else{
            
            if self.movieCollectionsValues?.count ?? 0 > 0{
                if let filterMovies = self.movieCollectionsValues?
                    .first(where: { $0.name == keyVal }), filterMovies.movieCollections?.count ?? 0 > 0{
                    Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: keyVal, collectionId: filterMovies._id )
                }
            }
        }
    }

    func hideAllViews(){
        self.tblHome.isHidden = true
        self.vwUpcomingTable.isHidden = true
        self.vwWebseriesTable.isHidden = true
        self.vwShortFilmsTable.isHidden = true
    }
    @IBAction func menuTapped(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            self.forceToSetStreaming()
            self.initialLoad()
            break
        case 1:
            self.resetTopMenuSeperator(view: self.vwUpcoming)
            self.hideAllViews()
            self.vwUpcomingTable.isHidden = false
            self.getUpcomingVideos()
            break
        case 2:
            self.resetTopMenuSeperator(view: self.vwWebseries)
            self.hideAllViews()
            self.vwWebseriesTable.isHidden = false
            self.getWebSeriesVideos()
            break
        case 3:
            self.resetTopMenuSeperator(view: self.vwShortFilms)
            self.hideAllViews()
            self.vwShortFilmsTable.isHidden = false
            self.getWebShortFilmsVideos()
            break
        case 4:
            Helper.shared.goToMovieSearch(viewController: self)
            break
        default:
            break
        }
    }
}

// API Methods
extension ZTHomeViewController{
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
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
    func getContinueWatching(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.getWatchListUsingGET( pageNumber: self.pageNumber, pageSize: self.pageSize) { (response, error) in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.continueWatching?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
    func getZettMoviesOriginals(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.zettaMovieOriginal.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.zettaMovieOriginals?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.zettaMovieOriginals?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
    func getAllCollections(isSpinnerNeeded:Bool){
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.allCollectionsUsingGET2(pageNumber: self.movieColPageNumber, pageSize: self.movieColPageSize) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.loadCollections(pageMCollections: responseVal)
                }else{
                    self.isPageEnable = false
                }
            }
        }
    }
    func loadCollections(pageMCollections:PageMCollections? = nil){
        
        if let dataVal = pageMCollections{
            if dataVal.last == true{
                self.isPageEnable = false
            }
            if let contentVal = dataVal.content, contentVal.count == 0{
                self.isPageEnable = false
            }else{
                for i in dataVal.content ?? []{
                    let value = i
                    if value.movieCollections?.count ?? 0 > 0{
                        let dataObj = value.name ?? ""
                        if !self.allTitles.contains(dataObj) {
                            self.allTitles.append(dataObj)
                            self.movieCollectionsValues?.append(value)
                        }
                        
                    }
                }
                DispatchQueue.main.async {
                    self.tblHome.reloadData()
                }
            }
        }else{
            self.isPageEnable = false
        }
    }
    func getPopularMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.movieSearchAvg.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.popularMovies?.removeAll()
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        
                    })
                    return
                }
                if let responseVal = response{
                    self.popularMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
    func getGenrieList(){
        if NetworkReachability.shared.isReachable {
            
            ZTCommonAPIWrapper.genresUsingGET(offset: nil, pageNumber: 0, pageSize: 1000, paged: nil, sortSorted: true, sortUnsorted: nil, unpaged: nil) { (response, error) in
                self.allGenres?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                      
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.allGenres?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
}

// Upcoming, Webseries and short films
extension ZTHomeViewController{
    func getUpcomingVideos(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.upcomingMovies( pageNumber: self.collectionPageNumber, pageSize: self.collectionPageSize, completion: { (response, error) in
                self.upcomingMovies?.removeAll()
                Helper.shared.removeNoView(fromView: self.upcomingCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        
                    })
                    return
                }
                if let responseVal = response, responseVal.content?.count ?? 0 > 0{
                    self.upcomingMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.upcomingCollection.reloadData()
                    }
                }else{
                    Helper.shared.showNoView(title: "", description: "", fromView: self.upcomingCollection, hideActionBtn: true, imageName: "",fromViewController: self )

                }
                
            })
        }
    }
    func getWebSeriesVideos(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.webSeries.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.webSeriesMovies?.removeAll()
                Helper.shared.removeNoView(fromView: self.upcomingCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                        
                    })
                    return
                }
                if let responseVal = response, responseVal.content?.count ?? 0 > 0{
                    self.webSeriesMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.webseriesCollection.reloadData()
                    }
                }else{
                    Helper.shared.showNoView(title: "", description: "", fromView: self.webseriesCollection, hideActionBtn: true, imageName: "",fromViewController: self )
                }
            }
        }
    }
    
    func getWebShortFilmsVideos(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.shortFilms.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.shortFilmsMovies?.removeAll()
                Helper.shared.removeNoView(fromView: self.upcomingCollection)

                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                        
                    })
                    return
                }
                if let responseVal = response, responseVal.content?.count ?? 0 > 0{
                    self.shortFilmsMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.shortFilmsCollection.reloadData()
                    }
                }else{
                    Helper.shared.showNoView(title: "", description: "", fromView: self.shortFilmsCollection, hideActionBtn: true, imageName: "",fromViewController: self )
                }
            }
        }
    }
}
//MARK: Collection View Methods

extension ZTHomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upcomingCollection{
            return self.upcomingMovies?.count ?? 0
        }else if collectionView == self.webseriesCollection{
            return self.webSeriesMovies?.count ?? 0
        }else{
            return self.shortFilmsMovies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upcomingCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
            cell.loadHomePageTopMenu(data: self.upcomingMovies?[indexPath.row], indexPath: indexPath)
            return cell

        }else if collectionView == self.webseriesCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
            cell.loadMoviesModel(data: self.webSeriesMovies?[indexPath.row], indexPath: indexPath)
            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
            cell.loadMoviesModel(data: self.shortFilmsMovies?[indexPath.row], indexPath: indexPath)
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.upcomingCollection{
            return CGSize(width: self.collectionWidth, height:  self.collectionHeight)
        }else if collectionView == self.webseriesCollection{
            return CGSize(width: self.collectionWidth, height:  self.collectionHeight)
        }else{
            return CGSize(width: self.collectionWidth, height:  self.collectionHeight)
        }
       }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.upcomingCollection{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: self.upcomingMovies?[indexPath.row])

        }else if collectionView == self.webseriesCollection{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: self.webSeriesMovies?[indexPath.row])
        }else{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: self.shortFilmsMovies?[indexPath.row])
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:1)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:1)
        }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    
}
extension ZTHomeViewController : ZTPagingDelegate, ZTHomePageDelegate, ZTSelectedGenresDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
    func selectedGenreIndex(tagVal: Int) {
        Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: self.allGenres?[tagVal].genreName ?? "", genreId: self.allGenres?[tagVal].genreId ?? -1)

    }
}
