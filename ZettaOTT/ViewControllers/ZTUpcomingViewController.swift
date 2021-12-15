//
//  ZTUpcomingViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 06/12/21.
//

import UIKit
import Alamofire
import SwiftUI
class ZTUpcomingViewController: UIViewController {
    @IBOutlet weak var tblHome: UITableView!
    var movieCollectionsValues : [MCollections]? = []
    var streamingNowMovies : [Movies]? = []
    var upcomingMovies : [Movies]? = []
    var continueWatching : [Movies]? = []
    var popularMovies : [Movies]? = []
    var allGenres : [Genres]? = []
    var allTitles = [moviesKeyUI.paging, moviesKeyUI.genres, moviesKeyUI.recommended, moviesKeyUI.popular_movies]
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
        self.tblHome.isHidden = true

        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
        }
    }
    
    func initialLoad(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getStreamingNowMovies()
            self.getUpcomingVideos()
            self.getPopularMovies()
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
extension ZTUpcomingViewController: UITableViewDelegate, UITableViewDataSource{
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
        }else if keyVal == moviesKeyUI.recommended {
            if self.upcomingMovies?.count ?? 0 > 0{
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
        }else{
            let cell: ZTHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTHomeTableViewCell, for: indexPath) as! ZTHomeTableViewCell
            if keyVal == moviesKeyUI.recommended {
                cell.loadPortraintVideos(videosVal: self.upcomingMovies, delegateObj: self, isExclusiveHide: false)
                return cell
            }
            else if keyVal == moviesKeyUI.popular_movies {
                cell.loadPortraintVideos(videosVal: self.popularMovies, delegateObj: self, isExclusiveHide: false)
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
            return cellHeight
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
            headerView.lblTitle.text = keyVal
            headerView.btnMore.isHidden = false
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
extension ZTUpcomingViewController{
    @objc func moreBtnTapped(sender: UIButton){
        let keyVal = self.allTitles[sender.tag]
        
        if keyVal == moviesKeyUI.genres || keyVal == moviesKeyUI.paging || keyVal == moviesKeyUI.recommended || keyVal == moviesKeyUI.popular_movies || keyVal == moviesKeyUI.popular_movies{
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
extension ZTUpcomingViewController{
    func refreshTable(){
        self.tblHome.isHidden = false
        DispatchQueue.main.async {
            self.tblHome.reloadData()
        }
    }
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
                    self.refreshTable()
                }
            }
        }
    }
    func getUpcomingVideos(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.upcomingMovies( pageNumber: self.collectionPageNumber, pageSize: self.collectionPageSize, completion: { (response, error) in
                self.upcomingMovies?.removeAll()
//                Helper.shared.removeNoView(fromView: self.upcomingCollection)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        
                    })
                    return
                }
                if let responseVal = response, responseVal.content?.count ?? 0 > 0{
                    self.upcomingMovies?.append(contentsOf: responseVal.content ?? [])
                    self.refreshTable()
                }else{
//                    Helper.shared.showNoView(title: "", description: "", fromView: self.upcomingCollection, hideActionBtn: true, imageName: "",fromViewController: self )

                }
                
            })
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
                    self.refreshTable()
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
                    self.refreshTable()
                }
            }
        }
    }
}
extension ZTUpcomingViewController : ZTPagingDelegate, ZTHomePageDelegate, ZTSelectedGenresDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
    func selectedGenreIndex(tagVal: Int) {
        Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: self.allGenres?[tagVal].genreName ?? "", genreId: self.allGenres?[tagVal].genreId ?? -1)

    }
}
