//
//  ZTMovieDetailViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/11/21.
//

import UIKit
//import VGPlayer
struct MyConstraint {
    static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: constraint.firstItem!,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: multiplier,
            constant: constraint.constant)
        
        newConstraint.priority = constraint.priority
        
        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
class ZTMovieDetailViewController: UIViewController {
    var videoPlayerSize : CGFloat = 0.3
    var videoBannerSize : CGFloat = 0.4
    var tryingCount = 0
    var videoUrlVal : URL? = nil
    @IBOutlet weak var btnMoreReview: UIButton!
    @IBOutlet weak var imgVwMovieBanner: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    @IBOutlet weak var collectionGenre: UICollectionView!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var collectionCast: UICollectionView!
    var moviewDetails : Movies? = nil
    @IBOutlet weak var stackTeaser: UIStackView!
    @IBOutlet weak var stackCast: UIStackView!
    @IBOutlet weak var stackSeason: UIStackView!
    @IBOutlet weak var stackRecommended: UIStackView!
    @IBOutlet weak var stackReviews: UIStackView!
    @IBOutlet weak var collectionRecommended: UICollectionView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReviesCount: UILabel!
    @IBOutlet weak var imgVwTeaser: UIImageView!
    @IBOutlet weak var imgVwTrailer: UIImageView!
    @IBOutlet weak var vwTeaser: UIView!
    @IBOutlet weak var vwTrailer: UIView!
    @IBOutlet weak var lblTeaserTitle: UILabel!
    @IBOutlet weak var lblTrailerTitle: UILabel!
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var carbonKitSeasonView: UIView!
    @IBOutlet weak var vwRateThisMoview: UIView!
    @IBOutlet weak var playerView: BMPlayer!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var videoHeightMultiplierHeight: NSLayoutConstraint!
    @IBOutlet weak var tblReviews: ZTContentSizedTableView!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var btnBookNow: UIButton!

    var recommendedMovies : [Movies]? = []
    var moviewReviews : [MovieReviews]? = []
    @IBOutlet weak var lblTblReviewsCount: UILabel!
    var readMoreClicked : Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerCells()
        self.initialLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = true
        AppUtility.lockOrientation(.all)

    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
        AppUtility.lockOrientation(.portrait)

    }
    func registerCells(){
        self.tblReviews.rowHeight = UITableView.automaticDimension
        self.tblReviews.estimatedRowHeight = 100
        self.tblReviews.isScrollEnabled = false
        self.tblReviews.register(UINib(nibName: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell)
        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell)
       
        self.collectionRecommended.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell)
        
        self.collectionCast.register(UINib(nibName: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell)
        

    }
    func multiplierHeightChange(sizeVal:CGFloat){
        self.videoHeightMultiplierHeight = MyConstraint.changeMultiplier(self.videoHeightMultiplierHeight, multiplier: sizeVal)
    }
    func initialLoad(){
        if ZTAppSession.sharedInstance.getIsUserLoggedIn() == true{
            self.vwRateThisMoview.isHidden = false
        }else{
            self.vwRateThisMoview.isHidden = true
        }
        
        self.videoPlayerView.isHidden = true
        self.multiplierHeightChange(sizeVal: self.videoBannerSize)
        self.refreshReadmoreUI()
        if let movieInfo = self.moviewDetails{
            if let paymentStatus = movieInfo.contactPaymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
                self.btnBookNow.setTitle(ZTConstants.BTN_BOOK_PLAY, for: .normal)
            }else{
                self.btnBookNow.setTitle(ZTConstants.BTN_BOOK_NOW, for: .normal)
            }
            self.lblMovieName.text = movieInfo.movieName
            self.lblMovieLanguage.text = movieInfo.primaryLanguage
            if let movieTime = movieInfo.runningTime{
               let convertToSec = Double(movieTime * 60)
                let stringVal = convertToSec.asString(style: .short)
                self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
            }
            self.lblMovieDescription.text = movieInfo.movieDescription
            Helper.shared.loadImage(url: movieInfo.moviePoster ?? "", imageView: self.imgVwMovieBanner)
            self.lblRating.text = String(format: "%.1f", movieInfo.avgRating ?? 0)
            self.lblMovieAge.text = String(format: "%d+", Int(movieInfo.ageRating ?? 0))
            self.lblMovieYear.text = String(format: "%d", Int(movieInfo.yearReleased ?? 0))
            self.lblReviesCount.text = String(format: "%d Reviews", Int(movieInfo.overallRank ?? 0))
            self.collectionCast.reloadData()
            self.collectionGenre.reloadData()
            if self.moviewDetails?.movieActors?.count ?? 0 > 0{
                self.stackCast.isHidden = false
            }else{
                self.stackCast.isHidden = true
            }
            self.vwTeaser.isHidden = true
            self.vwTrailer.isHidden = true
            if let teaser = self.moviewDetails?.teaserUrl, teaser.count > 0{
                self.vwTeaser.isHidden = false
                Helper.shared.loadImage(url: self.moviewDetails?.thumbnail ?? "", imageView: self.imgVwTeaser)
            }
            if let trailer = self.moviewDetails?.trailorUrl, trailer.count > 0{
                self.vwTrailer.isHidden = false
                Helper.shared.loadImage(url: self.moviewDetails?.thumbnail ?? "", imageView: self.imgVwTrailer)
            }
            self.lblTblReviewsCount.text = String(format: "%d Reviews", Int(movieInfo.overallRank ?? 0))
            self.getRecommendedMovies()
            self.getMovieReviews()
        }
    }
    @IBAction func btnWriteAReview(_ sender: Any) {
        Helper.shared.gotoWriteAReview(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnMoreReviews(_ sender: Any) {
        Helper.shared.goToRatingsReviews(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnTeaserPlay(_ sender: Any) {
        self.videoPlayerView.isHidden = false
        self.loadVideo(strUrl: self.moviewDetails?.teaserUrl ?? "")
    }
    func loadVideo(strUrl:String){
        if let url = URL.init(string: strUrl) {
            
        self.playerView.backBlock = { [unowned self] (isFullScreen) in
                if isFullScreen == true {
                    return
                }
                self.multiplierHeightChange(sizeVal: self.videoBannerSize)
                self.btnBack.isHidden = false
                self.videoPlayerView.isHidden = true
            }
            
            let asset = BMPlayerResource(url: url)
            self.playerView.setVideo(resource: asset)
            self.multiplierHeightChange(sizeVal: self.videoPlayerSize)
            self.btnBack.isHidden = true
        }
    }
    @IBAction func btnTrailerPlay(_ sender: Any) {
        
        self.videoPlayerView.isHidden = false
        self.loadVideo(strUrl: self.moviewDetails?.trailorUrl ?? "")

    }
    @IBAction func btnPlayTapped(_ sender: Any) {
        self.checkMoviePaymentStatus()
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func checkMoviePaymentStatus(){
        if let paymentStatus = self.moviewDetails?.contactPaymentStatus, paymentStatus == MoviePaymentStatusStruct.paid.rawValue{
            getMovieLink()
        }else{
            Helper.shared.goToChoosePlan(viewController: self, movieInfo: self.moviewDetails)
        }
    }
    func refreshReadmoreUI(){
        if self.readMoreClicked == true{
            self.lblMovieDescription.numberOfLines = 0
            self.btnReadMore.setTitle(ZTConstants.BTN_READLESS, for: .normal)
            self.view.setNeedsDisplay()
        }else{
            self.lblMovieDescription.numberOfLines = 2
            self.btnReadMore.setTitle(ZTConstants.BTN_READMORE, for: .normal)
            self.view.setNeedsDisplay()
        }
    }
    @IBAction func btnReadMoreTapped(_ sender: Any) {
        self.readMoreClicked = !self.readMoreClicked
        self.refreshReadmoreUI()
    }
    @IBAction func btnRateThisMovieTapped(_ sender: Any) {
        Helper.shared.gotoWriteAReview(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnReviewsTapped(_ sender: Any) {
        Helper.shared.goToRatingsReviews(viewController: self, movieInfo: self.moviewDetails)
    }
    @IBAction func btnBookNowTapped(_ sender: Any) {
        self.checkMoviePaymentStatus()
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
extension ZTMovieDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionCast{
            return self.moviewDetails?.movieActors?.count ?? 0
        }else if collectionView == self.collectionRecommended{
            return self.recommendedMovies?.count ?? 0
        }else if collectionView == self.collectionGenre{
            return self.moviewDetails?.movieGenres?.count ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionCast{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, for: indexPath) as! ZTCrewCollectionViewCell
            cell.loadCrewCaseDetails(data: self.moviewDetails?.movieActors?[indexPath.row])
            return cell

        }else if collectionView == self.collectionGenre{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
            cell.loadData(data: self.moviewDetails?.movieGenres?[indexPath.row].genre, indexPath: indexPath)
            return cell

        }else if collectionView == self.collectionRecommended{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTPortraitVideoCollectionViewCell, for: indexPath) as! ZTPortraitVideoCollectionViewCell
            let modelVal = self.recommendedMovies?[indexPath.row]
            cell.loadPortraitVideos(data: modelVal, isExclusiveHide: false)
            return cell
        }
        else{ // Teaser cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
           
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionCast{
            return CGSize(width: 80, height:  collectionView.frame.size.height)
        }else if collectionView == self.collectionRecommended{
            return CGSize(width: 133, height: collectionView.frame.size.height)
        }else if collectionView == self.collectionGenre{
            let item = self.moviewDetails?.movieGenres?[indexPath.row].genre?.genreName ?? ""
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let size = CGSize(width: 120, height: collectionView.frame.size.height)
            let estimatedFrame = NSString(string: item).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.setAppFontRegular(13.0)], context: nil)
            let attributes = [NSAttributedString.Key.font : UIFont.setAppFontRegular(13.0)]

            let yourLabelSize: CGSize = item.size(withAttributes:attributes )
                
            var width1 = yourLabelSize.width
            if width1 < 120 {
                    width1 = 120
            }
            return CGSize(width: estimatedFrame.width + 20, height: collectionView.frame.size.height)
        }else{
            return CGSize(width: 0, height:  0)
        }
    }
    
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionRecommended{
            if let movieInfo = self.recommendedMovies?[indexPath.row]{
                Helper.shared.goToMovieDetails(viewController: self, movieInfo: movieInfo)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: 1, height:collectionView.frame.size.height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height:collectionView.frame.size.height)
        }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionRecommended{
            return 1
        }
        return 5
    }
    
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionRecommended{
            return 1
        }
        return 5
    }
}

//TableView Delegate
extension ZTMovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.moviewReviews?.count ?? 0 > 2{
            return 2
        }else{
            return self.moviewReviews?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTUserReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, for: indexPath) as! ZTUserReviewTableViewCell
        cell.selectionStyle = .none
        cell.loadReviews(data: self.moviewReviews?[indexPath.row], indexPath: indexPath)
        return cell
    }
}
extension ZTMovieDetailViewController{
    func getRecommendedMovies(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.searchMoviesGET(search: MovieSearchTag.movieSearchAvg.rawValue, page: 0, size: 50) { (response, error) in
                self.recommendedMovies?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.recommendedMovies?.append(contentsOf: responseVal.content ?? [])
                    if self.recommendedMovies?.count ?? 0 > 0{
                        self.stackRecommended.isHidden = false
                    }
                    DispatchQueue.main.async {
                        self.collectionRecommended.reloadData()
                    }
                }
            }
        }
    }
    func getMovieReviews(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.movieReviewsByMovie(movieId: self.moviewDetails?.movieId ?? -1) { response, error in
                self.moviewReviews?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.moviewReviews?.append(contentsOf: responseVal.content ?? [])
                    if self.moviewReviews?.count ?? 0 > 0{
                        self.stackReviews.isHidden = false
                        if self.moviewReviews?.count ?? 0 > 2{
                            self.btnMoreReview.isHidden = false
                        }else{
                            self.btnMoreReview.isHidden = true
                        }
                    }
                    DispatchQueue.main.async {
                        self.tblReviews.reloadData()
                    }
                }
            }
        }
    }
    func getMovieLink(){
        if NetworkReachability.shared.isReachable {
            
            ZTCommonAPIWrapper.getMovieVideoUsingGET(movieId: self.moviewDetails?.movieId ?? -1) { response, error in
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    debugPrint("response\(responseVal)")
                    DispatchQueue.main.async {
                       
                    }
                }
            }
        }
    }
}
