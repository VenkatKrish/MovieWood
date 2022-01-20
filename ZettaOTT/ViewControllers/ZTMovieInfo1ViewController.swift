//
//  ZTMovieInfo1ViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 23/11/21.
//

import UIKit

struct LoadGenresType {
    var isSelected:Bool = false
    var genreVal:Genres? = nil
}
class ZTMovieInfo1ViewController: UIViewController {
    var allGenres : [LoadGenresType]? = []
    @IBOutlet weak var genreCollection: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtFldOriginalTitle: ZTCustomTextField!
    @IBOutlet weak var txtFldEnglishTitle: ZTCustomTextField!
    @IBOutlet weak var txtFldCountryIES: ZTCustomTextField!
    @IBOutlet weak var txtFldRunningTime: ZTCustomTextField!
    @IBOutlet weak var txtFldYearProduced: ZTCustomTextField!
    @IBOutlet weak var txtFldYearReleased: ZTCustomTextField!
    @IBOutlet weak var txtFldOriginalLanguage: ZTCustomTextField!
    var selectedGenres : [LoadGenresType]? = []
    @IBOutlet weak var txtFldProvideLink: ZTCustomTextField!
    @IBOutlet weak var txtFldSynopsis: ZTCustomTextField!
    var uploadMovieInfo : Movies? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        self.genreCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell)
        self.getGenrieList()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        if isValidationSuccess() == true{
//            Helper.shared.gotoMovieInfo2(viewController: self, movieInfo: self.uploadMovieInfo)
        }
    }
    func isValidationSuccess() -> Bool {
        self.view.endEditing(true)
        var isValidationSuccess = true
        var message = ""
        
        let originalTitle = self.removeWhiteSpace(text: self.txtFldOriginalTitle.text ?? "")
        let englishTitle = self.removeWhiteSpace(text: self.txtFldEnglishTitle.text ?? "")
        let countryIES = self.removeWhiteSpace(text: self.txtFldCountryIES.text ?? "")
        let runningTime = self.removeWhiteSpace(text: self.txtFldRunningTime.text ?? "")
        let yearProduced = self.removeWhiteSpace(text: self.txtFldYearProduced.text ?? "")
        let yearReleased = self.removeWhiteSpace(text: self.txtFldYearReleased.text ?? "")
        let originalLanguage = self.removeWhiteSpace(text: self.txtFldOriginalLanguage.text ?? "")
        let provideLink = self.removeWhiteSpace(text: self.txtFldProvideLink.text ?? "")
        let synopsis = self.removeWhiteSpace(text: self.txtFldSynopsis.text ?? "")
        
        self.selectedGenres = []
        
        
        if originalTitle.count == 0{
            message = ZTValidationMessage.Original_Title_REQUIRED
            isValidationSuccess = false
            self.txtFldOriginalTitle.showError()
        }
        
        if runningTime.count == 0{
            message = ZTValidationMessage.Running_Time_REQUIRED
            isValidationSuccess = false
            self.txtFldRunningTime.showError()
        }
        if originalLanguage.count == 0{
            message = ZTValidationMessage.Original_Language_REQUIRED
            isValidationSuccess = false
            self.txtFldOriginalLanguage.showError()
        }
        
        if provideLink.count == 0{
            message = ZTValidationMessage.Film_link_REQUIRED
            isValidationSuccess = false
            self.txtFldProvideLink.showError()
        }
        
        if synopsis.count == 0{
            message = ZTValidationMessage.Synopsis_Film_REQUIRED
            isValidationSuccess = false
            self.txtFldSynopsis.showError()
        }
        if isValidationSuccess == true{
            let dateStr:String = Helper.shared.getFormatedDate(dateVal: Date(), dateFormat: CustomDateFormatter.orderRequestDate)
            self.uploadMovieInfo = Movies(active: "N", adTagUri: nil, ageRating: 5, androidEnabled: nil, androidtvEnabled: nil, avgRating: nil, avodEnabled: nil, channelId: nil, contactEmail: "", contactName: "", contactPayment: nil, contactPaymentMethod: nil, contactPaymentPaid: nil, contactPaymentStatus: nil, contactPaymentTransno: nil, contactPhone: "", contactPlace: "", contactSignDate: dateStr, contactSignature: "", contentRating: nil, countryOfProduction: countryIES, createdBy: nil, createdOn: nil, featured: "", firetvEnabled: nil, hits: nil, image: "abc", iosTicketPrice: nil, lastUpdateLogin: nil, metaDesc: nil, metaKeywords: nil, metaTitle: nil, modifiedBy: nil, modifiedOn: nil, movieActors: nil, movieCrew: nil, movieDescription: synopsis, movieGenres: nil, movieId: nil, movieKey: nil, movieName: originalTitle, movieNameEn: englishTitle, moviePoster: "abc", movieSongs: nil, movieType: nil, movieViews: nil, overallRank: nil, parentId: nil, ppvCommission: nil, primaryLanguage: originalLanguage, promoColor: nil, promoDuration: nil, promoLabel: nil, promoUrl: nil, promoViews: nil, releaseDate: dateStr, releaseMonth: nil, rokutvEnabled: nil, runningTime: Int64(runningTime), showInIos: nil, streamingEndDate: nil, streamingStartDate: nil, subsCommission: nil, svodEnabled: nil, teaserDuration: nil, teaserUrl: nil, teaserViews: nil, thumbnail: nil, ticketRate: 500, trailorDuration: nil, trailorUrl: nil, trailorViews: nil, tvodEnabled: nil, usdTicketRate: nil, versionNumber: nil, views: nil, webMovieDetail: nil, webMoviePoster: nil, webStreamingNow: nil, website: "www", websiteEnabled: nil, yearProduced: Int64(yearProduced), yearReleased: Int64(yearReleased), paymentStatus: nil, playStatus: nil)
        }
        return isValidationSuccess
    }
}
extension ZTMovieInfo1ViewController{
    
    func getGenrieList(){
        if NetworkReachability.shared.isReachable {
            ZTCommonAPIWrapper.genresUsingGET(offset: nil, pageNumber: 0, pageSize: 100, paged: nil, sortSorted: true, sortUnsorted: nil, unpaged: nil) { (response, error) in
                self.allGenres?.removeAll()
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                      
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    if responseVal.content?.count ?? 0 > 0{
                        for i in responseVal.content ?? []{
                            self.allGenres?.append(LoadGenresType(isSelected: false, genreVal: i))
                        }
                        DispatchQueue.main.async {
                            self.genreCollection.reloadData()
                        }
                    }
                }
            }
        }
    }
}
extension ZTMovieInfo1ViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allGenres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, for: indexPath) as! ZTMovieInfoGenreCollectionViewCell
        
        cell.loadGenreDetails(data: self.allGenres?[indexPath.row], indexPath: indexPath)
        
        return cell
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
//     inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
}
extension ZTMovieInfo1ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 2.0
        
    return CGSize(width: yourWidth - 5, height: 50)

        
    }
}
extension ZTMovieInfo1ViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringVal = NSString(string: textField.text!)
        let newText = stringVal.replacingCharacters(in: range, with: string)
        if newText.count >= 1{
            (textField as? ZTCustomTextField)?.removeError()
        }
        
        if textField == self.txtFldOriginalTitle {
            return !(newText.count > Validation.Movie_title_length)
        }
        if textField == self.txtFldRunningTime {
            let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.Movie_running_time_length)
            }else{
                return false
            }
        }
        if textField == self.txtFldOriginalLanguage {
            return !(newText.count > Validation.Movie_title_length)
        }
        
        if textField == self.txtFldYearProduced || textField == self.txtFldYearReleased{
                   let cs = NSCharacterSet(charactersIn: ACCEPTABLE_PHONENO).inverted
                   let filtered = string.components(separatedBy: cs).joined(separator: "")
            if (string == filtered){
                return !(newText.count > Validation.Movie_year_length)
            }else{
                return false
            }
        }
        
        if newText.containsEmoji{
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){

        
    }
}
