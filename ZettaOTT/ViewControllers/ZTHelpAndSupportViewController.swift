//
//  ZTHelpAndSupportViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit


class ZTHelpAndSupportViewController: UIViewController {
    @IBOutlet weak var tblFAQs : UITableView!
    var pageSize : Int = 50
    var pageNumber : Int = 0
    var isPageEnable: Bool = true
    var faqsList : [FAQsStruct]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.tblFAQs.rowHeight = UITableView.automaticDimension
        self.tblFAQs.register(UINib(nibName: ZTCellNameOrIdentifier.ZTFAQsTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTFAQsTableViewCell)
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tblFAQs.tableHeaderView = view
        self.tblFAQs.dataSource = self
        self.tblFAQs.delegate = self

        self.loadFAQs()
    }
    func loadFAQs(){
        self.pageNumber = 0
        self.getFAQs(isSpinnerNeeded: true)
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
extension ZTHelpAndSupportViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.faqsList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTFAQsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTFAQsTableViewCell, for: indexPath) as! ZTFAQsTableViewCell
        cell.selectionStyle = .none
        cell.loadFAQs(data: self.faqsList?[indexPath.row], indexPath: indexPath, btnDelegate: self)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.refreshFAQs(tagVal: indexPath.row)
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isPageEnable == true {
            if   indexPath.row ==  self.faqsList?.count ?? 0 - 1 {
                debugPrint(indexPath.row)
                self.pageNumber = self.pageNumber + 1
                self.getFAQs(isSpinnerNeeded: false)
            }
        }
    }
    
}
extension ZTHelpAndSupportViewController{
    func getFAQs(isSpinnerNeeded:Bool = false){
        if NetworkReachability.shared.isReachable{
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.tblFAQs, setDarkBackground: false)
            }
            ZTCommonAPIWrapper.getFAQs(pageNumber: self.pageNumber, pageSize: self.pageSize) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
                if self.pageNumber == 0{
                    self.faqsList?.removeAll()
                }
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{                    for i in responseVal.content ?? []{
                        self.faqsList?.append(FAQsStruct(isSelected: false, faqModel: i))
                    }
                   
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }
                    DispatchQueue.main.async {
                        if self.faqsList?.count ?? 0 == 0{
                            Helper.shared.showNoView(fromView: self.tblFAQs, fromViewController: self, needToSetTop: false)
                        }
                        self.tblFAQs.reloadData()
                    }
                }
            }
        }
    }
}
extension ZTHelpAndSupportViewController:BtnArrowTappedDelegate{
    func btnTapped(tag: Int) {
        self.refreshFAQs(tagVal: tag)
    }
    func refreshFAQs(tagVal:Int){
        if let val = self.faqsList?[tagVal]{
            if val.isSelected == true{
                self.faqsList?[tagVal].isSelected = false
            }else{
                self.faqsList?[tagVal].isSelected = true
            }
            self.tblFAQs.reloadData()
        }
    }
}
