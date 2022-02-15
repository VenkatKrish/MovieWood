import UIKit

class ZTChannelMoviesListViewController: UIViewController {
   
    @IBOutlet weak var movieListCollection: UICollectionView!
    var videosList : [Movies]? = []
    var collectionsList : [MovieCollections]? = []
    var isPageEnable: Bool = true
    @IBOutlet weak var lblTitle: UILabel!
    var collectionWidth:CGFloat = 0
    var collectionHeight:CGFloat = 0
    var pageNumber : Int = 0
    var pageSize : Int = 50
    var channelInfo:Channels? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.pageNumber = 0
        self.lblTitle.text = self.channelInfo?.channelName ?? ""
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
        self.getMoviesList(isSpinnerNeeded: isSpinnerNeeded)
        
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCells(){
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        self.movieListCollection.collectionViewLayout = layout
        
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

extension ZTChannelMoviesListViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videosList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTVideoTileCollectionViewCell, for: indexPath) as! ZTVideoTileCollectionViewCell
        cell.loadMoviesModel(data: self.videosList?[indexPath.row], indexPath: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
               
                let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing
               
                return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieModel = self.videosList?[indexPath.row]{
            Helper.shared.goToChannelsMovieDetails(viewController: self, movieInfo: movieModel)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                            
        return CGSize(width: collectionView.frame.size.width, height:16)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 1)
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.isPageEnable == true {
            if  indexPath.row ==  (self.videosList?.count ?? 0) - 1{
                self.pageNumber = self.pageNumber + 1
                self.initialLoad(isSpinnerNeeded: false)
            }
        }
       }

}

extension ZTChannelMoviesListViewController{
    func getMoviesList(isSpinnerNeeded:Bool){
        
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.getMovieByChannelUsingGET(channelId: self.channelInfo?.channelId ?? -1) { response, error in
                DispatchQueue.main.async {
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
        }
        if self.videosList?.count ?? 0 == 0{
            Helper.shared.showNoView(title: "", description: "", fromView: self.movieListCollection, hideActionBtn: true, imageName: "",fromViewController: self )
        }
    }
}

