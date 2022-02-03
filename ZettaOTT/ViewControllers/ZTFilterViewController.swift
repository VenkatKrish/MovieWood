//
//  ZTFilterViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 02/02/22.
//

import UIKit
protocol FilterDelegate{
    func filterSearchKeys(searchKey:String, searchKey2:String, sortedDate:Bool, sortedRating:Bool, genreArray:[LoadGenresType], langArray:[LoadLanguageType])
}
class ZTFilterViewController: UIViewController {
    var collectionCellHeight : Int = 50
    var delegate:FilterDelegate? = nil
    @IBOutlet weak var collectionGenre: UICollectionView!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    var isRatingFilter : Bool = false
    var isDateFilter : Bool = false
    @IBOutlet weak var lblDivider: UILabel!
    var searchKeyVal:String = ""
    var allGenres : [LoadGenresType]? = []
    var allLanguages : [LoadLanguageType]? = []
    var allTitles = [moviesKeyUI.col_title_genre, moviesKeyUI.col_title_languages]
    var filterGenreVal : [LoadGenresType] = []
    var filterLangVal : [LoadLanguageType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDivider.layer.cornerRadius = 2.0
        self.lblDivider.clipsToBounds = true
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func unselectedBtn(btn:UIButton){
        btn.layer.cornerRadius = 15.0
        btn.layer.borderColor = UIColor.getColor(colorVal: ZTOTPBorderColor).cgColor
        btn.layer.borderWidth = 2.0
        btn.backgroundColor = UIColor.getColor(colorVal: ZTAppWhiteColor)
        btn.setTitleColor(UIColor.getColor(colorVal: ZTAppBlackColor), for: .normal)
    }
    func selectedBtn(btn:UIButton){
        btn.layer.cornerRadius = 15.0
        btn.layer.borderColor = UIColor.getColor(colorVal: ZTGradientColor1).cgColor
        btn.backgroundColor = UIColor.getColor(colorVal: ZTGradientColor1)
        btn.setTitleColor(UIColor.getColor(colorVal: ZTAppWhiteColor), for: .normal)
    }
    func initialLoad(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        layout.collectionView?.backgroundColor = UIColor.getColor(colorVal: ZTBackgroundColor)
        self.collectionGenre.collectionViewLayout = layout
        
        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell)
        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTFilterHeaderCollectionReusableView, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTFilterHeaderCollectionReusableView)

        self.collectionGenre.register(UINib(nibName: ZTCellNameOrIdentifier.ZTProfileFooter, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter)
        self.updateRating()
        self.updateDateFilter()
        self.getGenrieList()
        self.getLanguageList()
        
    }
    func updateRating(){
        if self.isRatingFilter == true{
            self.isRatingFilter = false
            self.unselectedBtn(btn: self.btnRating)
        }else{
            self.isRatingFilter = true
            self.selectedBtn(btn: self.btnRating)
        }
    }
    func updateDateFilter(){
        if self.isDateFilter == true{
            self.isDateFilter = false
            self.unselectedBtn(btn: self.btnDate)

        }else{
            self.isDateFilter = true
            self.selectedBtn(btn: self.btnDate)
        }
    }
    @IBAction func btnRatingTapped(_ sender: Any) {
        self.updateRating()
    }
    @IBAction func btnDateTapped(_ sender: Any) {
        self.updateDateFilter()
    }
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            var genreIds = ""
            var lanName = ""
            var sortedDate = ""
            var sortedRating = ""
            self.filterGenreVal.removeAll()
            self.filterLangVal.removeAll()
            if let filterGenre = self.allGenres?.filter({ $0.isSelected == true}), filterGenre.count > 0{
                self.filterGenreVal.append(contentsOf: filterGenre)
                for (index, i) in filterGenre.enumerated(){
                    if index > 0{
                        genreIds = String(format: "%@;%d",genreIds,Int(i.genreVal?.genreId ?? 0))
                    }else{
                        genreIds = String(format: "%d", Int(i.genreVal?.genreId ?? 0))
                    }
                }
                genreIds = String(format: "%@%@", MovieSearchTag.genresFilter.rawValue, genreIds)
            }
            if let filterLang = self.allLanguages?.filter({ $0.isSelected == true}), filterLang.count > 0{
                self.filterLangVal.append(contentsOf: filterLang)
                for (index, i) in filterLang.enumerated(){
                    if index > 0{
                        lanName = String(format: "%@;%@",lanName,i.langVal?.languageName ?? "")
                    }else{
                        lanName = String(format: "%@", i.langVal?.languageName ?? "")
                    }
                }
                lanName = String(format: "%@%@", MovieSearchTag.langFilter.rawValue, lanName)
            }
            if self.isDateFilter == true{
                sortedDate = MovieSearchTag.sortByDate.rawValue
            }
            if self.isRatingFilter == true{
                sortedRating = MovieSearchTag.sortByRating.rawValue
            }
            self.searchKeyVal = String(format: "%@%@%@%@%@", MovieSearchTag.commonSearchKey.rawValue, sortedDate, sortedRating, genreIds, lanName)
            
            let searchKey2 = String(format: "%@%@%@%@", MovieSearchTag.commonSearchKey.rawValue, sortedDate, sortedRating, genreIds)
            
            self.delegate?.filterSearchKeys(searchKey: self.searchKeyVal, searchKey2: searchKey2, sortedDate: self.isDateFilter, sortedRating: self.isRatingFilter, genreArray: self.filterGenreVal, langArray: self.filterLangVal)
        })
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
extension ZTFilterViewController{
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
                    for i in responseVal.content ?? []{
                        if !self.filterGenreVal.contains(where: { $0.genreVal?.genreId == i.genreId }) {
                            self.allGenres?.append(LoadGenresType(isSelected: false, genreVal: i))
                        }
                    }
                    
                }
                self.refreshTable()
            }
        }
    }
    func refreshTable(){
        DispatchQueue.main.async {
            self.collectionGenre.reloadData()
        }
    }
    func getLanguageList(){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.getLanguages(pageNumber: 0, pageSize: 100) { response, error in
                self.allLanguages?.removeAll()
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                      
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    for i in responseVal.content ?? []{
                        
                        if !self.filterLangVal.contains(where: { $0.langVal?.languageId == i.languageId }) {
                            self.allLanguages?.append(LoadLanguageType(isSelected: false, langVal: i))
                        }
                    }
                    DispatchQueue.main.async {
                        self.refreshTable()
                    }
                }
            }
        }
    }
}
//MARK: Collection View Methods
extension ZTFilterViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.frame.width
        let widthPerItem = width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: CGFloat(self.collectionCellHeight))
        
    }
}
extension ZTFilterViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.allTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let titleVal = self.allTitles[section]
        
        if titleVal == moviesKeyUI.col_title_genre {
            return self.allGenres?.count ?? 0
        }else{
            return self.allLanguages?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieInfoGenreCollectionViewCell, for: indexPath) as! ZTMovieInfoGenreCollectionViewCell
        let titleVal = self.allTitles[indexPath.section]
        if titleVal == moviesKeyUI.col_title_genre {
            cell.loadFilterGenreDetails(data: self.allGenres?[indexPath.row], indexPath: indexPath, delegateVal: self)
            return cell
        }else{
            cell.loadFilterLanguageDetails(data: self.allLanguages?[indexPath.row], indexPath: indexPath, delegateVal: self)
            return cell
        }
            
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
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ZTCellNameOrIdentifier.ZTFilterHeaderCollectionReusableView, for: indexPath) as! ZTFilterHeaderCollectionReusableView
                
            reusableview.lblTitle.text = self.allTitles[indexPath.section]
            return reusableview
        }else{
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter, for: indexPath) as! ZTProfileFooter
                return reusableview
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:1)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
        }

}
extension ZTFilterViewController : btnCheckBoxDelegate{
    func btnCheckBoxTapped(btn: UIButton) {
        
    }
    
    func btnCheckBoxFilterTapped(btn: UIButton, filterType: String) {
        if filterType == moviesKeyUI.col_title_genre{
            if self.allGenres?[btn.tag].isSelected == true{
                self.allGenres?[btn.tag].isSelected = false
            }else{
                self.allGenres?[btn.tag].isSelected = true
            }
            self.collectionGenre.reloadData()
        }else{
            if self.allLanguages?[btn.tag].isSelected == true{
                self.allLanguages?[btn.tag].isSelected = false
            }else{
                self.allLanguages?[btn.tag].isSelected = true
            }
            self.collectionGenre.reloadData()
        }
    }
}
