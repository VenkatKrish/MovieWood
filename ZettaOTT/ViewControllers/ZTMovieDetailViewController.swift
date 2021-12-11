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
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReviesCount: UILabel!
    @IBOutlet weak var imgVwTeaser: UIImageView!
    @IBOutlet weak var imgVwTrailer: UIImageView!
    @IBOutlet weak var vwTeaser: UIView!
    @IBOutlet weak var vwTrailer: UIView!
    @IBOutlet weak var lblTeaserTitle: UILabel!
    @IBOutlet weak var lblTrailerTitle: UILabel!
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var playerView: BMPlayer!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var videoHeightMultiplierHeight: NSLayoutConstraint!
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
        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell)
       
        self.collectionCast.register(UINib(nibName: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTCrewCollectionViewCell)
        

    }
    func multiplierHeightChange(sizeVal:CGFloat){
        self.videoHeightMultiplierHeight = MyConstraint.changeMultiplier(self.videoHeightMultiplierHeight, multiplier: sizeVal)
    }
    func initialLoad(){
        self.videoPlayerView.isHidden = true
        self.multiplierHeightChange(sizeVal: self.videoBannerSize)
        
        if let movieInfo = self.moviewDetails{
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
                Helper.shared.loadImage(url: self.moviewDetails?.webMoviePoster ?? "", imageView: self.imgVwTeaser)
            }
            if let trailer = self.moviewDetails?.trailorUrl, trailer.count > 0{
                self.vwTrailer.isHidden = false
                Helper.shared.loadImage(url: self.moviewDetails?.webMoviePoster ?? "", imageView: self.imgVwTrailer)
            }
        }
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
      
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnReadMoreTapped(_ sender: Any) {

    }
    @IBAction func btnRateThisMovieTapped(_ sender: Any) {

    }
    @IBAction func btnReviewsTapped(_ sender: Any) {

    }
    @IBAction func btnBookNowTapped(_ sender: Any) {

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

        }else{ // Teaser cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTTypesOfVideosCollectionViewCell, for: indexPath) as! ZTTypesOfVideosCollectionViewCell
           
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionCast{
            return CGSize(width: 80, height:  collectionView.frame.size.height)
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
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: 1, height:collectionView.frame.size.height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height:collectionView.frame.size.height)
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
