//
//  ZTChannelMoviePlaysViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 15/02/22.
//
import UIKit

class ZTChannelMoviePlaysViewController: UIViewController {
    var movieInfo:Movies? = nil
    @IBOutlet weak var tblTransactions : UITableView!
    var transactionsList : [MoviePlays]? = []
    var pageSize : Int = 50
    var pageNumber : Int = 0
    var isPageEnable: Bool = true
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.getColor(colorVal: ZTGradientColor1)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.getColor(colorVal: ZTGradientColor1)]
        refreshControl.attributedTitle = NSAttributedString(string: ZTConstants.PLEASE_WAIT_LOADING, attributes: attributes)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pageNumber = 0
        self.loadOrders()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.tblTransactions.rowHeight = UITableView.automaticDimension
        self.tblTransactions.register(UINib(nibName: ZTCellNameOrIdentifier.ZTChannelMovieOrderTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTChannelMovieOrderTableViewCell)
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tblTransactions.tableHeaderView = view
        self.tblTransactions.addSubview(self.refreshControl)
        self.tblTransactions.dataSource = self
        self.tblTransactions.delegate = self
        self.tblTransactions.reloadData()

        self.loadOrders()
    }
    func loadOrders(){
        self.pageNumber = 0
        self.getOrders(isSpinnerNeeded: true)
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
extension ZTChannelMoviePlaysViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionsList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTChannelMovieOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTChannelMovieOrderTableViewCell, for: indexPath) as! ZTChannelMovieOrderTableViewCell
        cell.selectionStyle = .none
        cell.loadMoviePlaysDetails(dataVal: self.transactionsList?[indexPath.row], indexPath: indexPath, delegateVal: self, movieInfo: self.movieInfo)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isPageEnable == true {
            if   indexPath.row ==  self.transactionsList?.count ?? 0 - 1 {
                debugPrint(indexPath.row)
                self.pageNumber = self.pageNumber + 1
                self.getOrders(isSpinnerNeeded: false)
            }
        }
    }
    
}
extension ZTChannelMoviePlaysViewController{
    func getOrders(isSpinnerNeeded:Bool = false){
        if NetworkReachability.shared.isReachable{
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.tblTransactions, setDarkBackground: false)
            }
            ZTCommonAPIWrapper.playsByMovieIdUsingGET(movieId: self.movieInfo?.movieId ?? -1, pageNumber: self.pageNumber, pageSize: self.pageSize, sort:SortingStruct.sort_playTimeOn_desc.rawValue) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)

                }
                DispatchQueue.main.async {
                    if self.refreshControl.isRefreshing{
                        self.refreshControl.endRefreshing()
                    }
                }
                if self.pageNumber == 0{
                    self.transactionsList?.removeAll()
                }
                
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.transactionsList?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }
                    DispatchQueue.main.async {
                        if self.transactionsList?.count ?? 0 == 0{
                            Helper.shared.showNoView(fromView: self.tblTransactions, fromViewController: self, needToSetTop: false)
                        }
                        self.tblTransactions.reloadData()
                    }
                }
            }
        
        }
    }
}
extension ZTChannelMoviePlaysViewController : btnDetailsDelegate{
    func btnDetailsTapped(btn: UIButton) {
        if let modelVal = self.transactionsList?[btn.tag]{
            Helper.shared.goToPayPerView(viewController: self, orderInfo: nil, playsInfo: modelVal, movieInfo:self.movieInfo)
        }
    }
}
