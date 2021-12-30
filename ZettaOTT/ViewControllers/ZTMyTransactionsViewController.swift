//
//  ZTMyTransactionsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTMyTransactionsViewController: UIViewController {
    @IBOutlet weak var tblTransactions : UITableView!
    var transactionsList : [Orders]? = []
    var pageSize : Int = 50
    var pageNumber : Int = 0
    var isPageEnable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.tblTransactions.rowHeight = UITableView.automaticDimension
        self.tblTransactions.register(UINib(nibName: ZTCellNameOrIdentifier.ZTMyTransactionsTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTMyTransactionsTableViewCell)
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tblTransactions.tableHeaderView = view
        
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
extension ZTMyTransactionsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionsList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTMyTransactionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTMyTransactionsTableViewCell, for: indexPath) as! ZTMyTransactionsTableViewCell
        cell.selectionStyle = .none
        cell.loadOrderDetails(data: self.transactionsList?[indexPath.row], indexPath: indexPath)
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
extension ZTMyTransactionsViewController{
    func getOrders(isSpinnerNeeded:Bool = false){
        if NetworkReachability.shared.isReachable{
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.tblTransactions, setDarkBackground: false)
            }
            ZTCommonAPIWrapper.allOrders(pageNumber: self.pageNumber, pageSize: self.pageSize, sortSorted: true) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)

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
