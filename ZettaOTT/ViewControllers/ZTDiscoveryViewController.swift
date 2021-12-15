//
//  ZTDiscoveryViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit

class ZTDiscoveryViewController: UIViewController {
    @IBOutlet weak var tblHome: UITableView!
    var streamingNowMovies : [Movies]? = []
    var recommendedMovies : [Movies]? = []
    var latestTamilMovies : [Movies]? = []
    var allGenres : [Genres]? = []
    var allTitles = [moviesKeyUI.genres, moviesKeyUI.recommended,
        moviesKeyUI.paging,
        moviesKeyUI.latest_tamil_movies]
    var pageSize : Int = 10
    var pageNumber : Int = 0
    var movieColPageSize : Int = 5
    var movieColPageNumber : Int = 0
    var isPageEnable: Bool = true
    var movieCollectionsValues : [MCollections]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view.takeScreenshot()
    }
    func initialLoad(){
        self.getStreamingNowMovies()
        self.getLatestTamilMovies()
        self.getRecommendedMovies()
        self.getGenrieList()
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
extension ZTDiscoveryViewController: UITableViewDelegate, UITableViewDataSource{
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
            if self.recommendedMovies?.count ?? 0 > 0{
                return 1
            }
        }else if keyVal == moviesKeyUI.latest_tamil_movies {
            if self.latestTamilMovies?.count ?? 0 > 0{
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
                cell.loadPortraintVideos(videosVal: self.recommendedMovies, delegateObj: self, isExclusiveHide: false)
                return cell
            }
            else if keyVal == moviesKeyUI.latest_tamil_movies {
                cell.loadPortraintVideos(videosVal: self.latestTamilMovies, delegateObj: self, isExclusiveHide: false)
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
                if keyVal == moviesKeyUI.recommended {
                    if self.recommendedMovies?.count ?? 0 >= self.pageSize{
                        headerView.btnMore.isHidden = false
                    }
                }else if keyVal == moviesKeyUI.latest_tamil_movies{
                    if self.latestTamilMovies?.count ?? 0 >= self.pageSize{
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
extension ZTDiscoveryViewController{
    @objc func moreBtnTapped(sender: UIButton){
        let keyVal = self.allTitles[sender.tag]
        
        if keyVal == moviesKeyUI.genres || keyVal == moviesKeyUI.paging || keyVal == moviesKeyUI.recommended || keyVal == moviesKeyUI.latest_tamil_movies{
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
    @IBAction func menuTapped(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            break
        case 1:
            Helper.shared.goToMovieSearch(viewController: self)
            break
        default:
            break
        }
    }
}

// API Methods
extension ZTDiscoveryViewController{
    func getStreamingNowMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.streamNow(pageNumber: self.pageNumber, pageSize: self.pageSize, sortSorted: true) { (response, error) in
                self.streamingNowMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        Helper().showSnackBarAlert(message: errorMsg, type: .Failure, superView: self)
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
    func getLatestTamilMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.zettaMovieOriginal.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.latestTamilMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        Helper().showSnackBarAlert(message: errorMsg, type: .Failure, superView: self)
                    })
                    return
                }
                if let responseVal = response{
                    self.latestTamilMovies?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
    func getRecommendedMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.movieSearchAvg.rawValue, page: self.pageNumber, size: self.pageSize) { (response, error) in
                self.recommendedMovies?.removeAll()
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.recommendedMovies?.append(contentsOf: responseVal.content ?? [])
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
    func getGenrieList(){
        if NetworkReachability.shared.isReachable {
            
            ZTCommonAPIWrapper.genresUsingGET(offset: nil, pageNumber: 0, pageSize: 100, paged: nil, sortSorted: true, sortUnsorted: nil, unpaged: nil) { (response, error) in
                self.allGenres?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                        Helper().showSnackBarAlert(message: errorMsg, type: .Failure, superView: self)
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
extension ZTDiscoveryViewController : ZTPagingDelegate, ZTHomePageDelegate, ZTSelectedGenresDelegate{
    func selectedVideoModel(movieInfo: Movies, indexVal: Int) {
        Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
    }
    func selectedGenreIndex(tagVal: Int) {
        Helper.shared.goToMoviesCategoryListScreen(viewController: self, movieKey: self.allGenres?[tagVal].genreName ?? "", genreId: self.allGenres?[tagVal].genreId ?? -1)
    }
}
