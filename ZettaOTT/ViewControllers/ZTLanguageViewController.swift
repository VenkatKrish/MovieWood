//
//  ZTLanguageViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 30/11/21.
//

import UIKit

class ZTLanguageViewController: UIViewController {
    @IBOutlet weak var tblHome: UITableView!
    var pageSize : Int = 500
    var pageNumber : Int = 0
    var languages : [Languages]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func initialLoad(){
        self.tblHome.register(UINib(nibName: ZTCellNameOrIdentifier.ZTLanguageTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTLanguageTableViewCell)
        self.getLanguageList()
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
extension ZTLanguageViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.languages?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTLanguageTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTLanguageTableViewCell, for: indexPath) as! ZTLanguageTableViewCell
        cell.lblLanguageName.text = self.languages?[indexPath.row].languageName ?? ""
        cell.vwChecked.isHidden = true
        return cell
    }
    
    
}
extension ZTLanguageViewController{
    func getLanguageList(){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.getLanguages(pageNumber: self.pageNumber, pageSize: self.pageSize) { response, error in
                self.languages?.removeAll()
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                      
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.languages?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.tblHome.reloadData()
                    }
                }
            }
        }
    }
}
