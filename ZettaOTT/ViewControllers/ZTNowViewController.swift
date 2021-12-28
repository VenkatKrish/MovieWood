//
//  ZTNowViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/12/21.
//
import UIKit
import Alamofire
import SwiftUI
class ZTNowViewController: UIViewController {
    @IBOutlet weak var tblHome: UITableView!
    var movieCollectionsValues : [MCollections]? = []
    var streamingNowMovies : [Movies]? = []
    var zettaMovieOriginals : [Movies]? = []
    var continueWatching : [Movies]? = []
    var webSeriesMovies : [Movies]? = []
    var allGenres : [Genres]? = []
    var allTitles = [moviesKeyUI.paging, moviesKeyUI.continue_watching, moviesKeyUI.genres, moviesKeyUI.zetta_movies_originals, moviesKeyUI.latest_web_series]
    @IBOutlet weak var vwNew: UIView!
    @IBOutlet weak var vwUpcoming: UIView!
    @IBOutlet weak var vwWebseries: UIView!
    @IBOutlet weak var vwShortFilms: UIView!
    var pageSize : Int = 10
    var pageNumber : Int = 0
    
    var movieColPageSize : Int = 5
    var movieColPageNumber : Int = 0
    
    var isPageEnable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.refreshTable()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
        }
    }
    
    func initialLoad(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getStreamingNowMovies()
            if ZTAppSession.sharedInstance.getIsUserLoggedIn(){
                self.getContinueWatching()
            }
            self.getZettMoviesOriginals()
            self.getWebSeriesVideos(isSpinnerNeeded: false)
            self.getGenrieList()
            self.movieColPageNumber = 0
            self.getAllCollections(isSpinnerNeeded: true)
        }
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
        
        
    }

}
extension ZTNowViewController: UITableViewDelegate, UITableViewDataSource{
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
        }else if keyVal == moviesKeyUI.latest_web_series {
            if self.webSeriesMovies?.count ?? 0 > 0{
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
            cell.loadContinueWatching(videosVal: self.continueWatching, delegateObj: self)
            return cell
        }else{
            let cell: ZTHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTHomeTableViewCell, for: indexPath) as! ZTHomeTableViewCell
            if keyVal == moviesKeyUI.zetta_movies_originals {
                cell.loadPortraintVideos(videosVal: self.zettaMovieOriginals, delegateObj: self, isExclusiveHide: false)
                return cell
            }
            else if keyVal == moviesKeyUI.latest_web_series {
                cell.loadPortraintVideos(videosVal: self.webSeriesMovies, delegateObj: self, isExclusiveHide: false)
                return cell
            }else{
                if self.movieCollectionsValues?.count ?? 0 > 0{
                    if let filterMovies = self.movieCollectionsValues?
                        .first(where: { $0.name == keyVal }), filterMovies.movieCollections?.count ?? 0 > 0{
                        cell.loadPortraintVideos(videosVal: filterMovies.movieCollections ?? [], delegateObj: self, isExclusiveHide: false) // will change the model and array
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
                }
            }else{
                if keyVal == moviesKeyUI.zetta_movies_originals {
                    if self.zettaMovieOriginals?.count ?? 0 > 0{
                        return cellHeight
                    }
                }else if keyVal == moviesKeyUI.latest_web_series{
                    if self.webSeriesMovies?.count ?? 0 > 0{
                        return cellHeight
                    }
                }else{
                    if self.movieCollectionsValues?.count ?? 0 > 0{
                        if let filterMovies = self.movieCollectionsValues?
                            .first(where: { $0.name == keyVal }), filterMovies.movieCollections?.count ?? 0 > 0{
                            if filterMovies.movieCollections?.count ?? 0 >= 0{
                                return cellHeight
                            }
                        }
                    }
                }
                return 0.1
            }
        }
        return 0.1
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
                    if self.continueWatching?.count ?? 0 >= self.pageSize{
                        headerView.btnMore.isHidden = false
                    }
                }
            }else{
                headerView.lblTitle.text = keyVal
                if keyVal == moviesKeyUI.zetta_movies_originals {
                    if self.zettaMovieOriginals?.count ?? 0 >= self.pageSize{
                        headerView.btnMore.isHidden = false
                    }
                }else if keyVal == moviesKeyUI.latest_web_series{
                    if self.webSeriesMovies?.count ?? 0 >= self.pageSize{
                        headerView.btnMore.isHidden = false
                    }
                }else{
                    if self.movieCollectionsValues?.count ?? 0 > 0{
                        if let filterMovies = self.movieCollectionsValues?
                            .first(where: { $0.name == keyVal }), filterMovies.movieCollections?.count ?? 0 > 0{
                            if filterMovies.movieCollections?.count ?? 0 >= self.pageSize{
                                headerView.btnMore.isHidden = false
                            }
                        }
                    }
                }
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
extension ZTNowViewController{
    @objc func moreBtnTapped(sender: UIButton){
        let keyVal = self.allTitles[sender.tag]
        
        if keyVal == moviesKeyUI.genres || keyVal == moviesKeyUI.paging || keyVal == moviesKeyUI.continue_watching || keyVal == moviesKeyUI.zetta_movies_originals || keyVal == moviesKeyUI.latest_web_series{
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
}

// API Methods
extension ZTNowViewController{
    func getStreamingNowMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.streamNow(pageNumber: self.pageNumber, pageSize: self.pageSize, sortSorted: true, contenttype: MovieSearchTag.streamNow.rawValue) { (response, error) in
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
                    self.refreshTable()
                }
            }
        }
    }
    func refreshTable(){
        DispatchQueue.main.async {
            self.tblHome.reloadData()
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
            }
            self.refreshTable()
        }else{
            self.isPageEnable = false
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
                        
                        self.webSeriesMovies?.append(contentsOf: responseVal.content ?? [])
                        
                    }
                    self.refreshTable()
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
                }
                self.refreshTable()
            }
        }
    }
}
extension ZTNowViewController : ZTPagingDelegate, ZTHomePageDelegate, ZTSelectedGenresDelegate, ZTContinueWatchingDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
    func selectedGenreIndex(tagVal: Int) {
        Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: self.allGenres?[tagVal].genreName ?? "", genreId: self.allGenres?[tagVal].genreId ?? -1)

    }
}
