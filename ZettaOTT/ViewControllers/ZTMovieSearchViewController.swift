//
//  ZTMovieSearchViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 10/10/21.
//

import UIKit

class ZTMovieSearchViewController: UIViewController {
    @IBOutlet weak var tblMovieSearch : UITableView!
    var videosList : [Movies]? = []
    @IBOutlet weak var txtFldSearch : UITextField!
    var pageSize : Int = 50
    var pageNumber : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        self.registerCells()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.txtFldSearch.placeholder = "Search movie..."
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func registerCells(){
        self.tblMovieSearch.layer.cornerRadius = 5
        self.tblMovieSearch.layer.masksToBounds = true
        self.tblMovieSearch.rowHeight = UITableView.automaticDimension

        self.tblMovieSearch.register(UINib(nibName: ZTCellNameOrIdentifier.ZTMovieCustomTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTMovieCustomTableViewCell)
        let view = UIView()
        view.backgroundColor = UIColor.clear
        self.tblMovieSearch.tableHeaderView = view
        
        self.tblMovieSearch.dataSource = self
        self.tblMovieSearch.delegate = self
        self.tblMovieSearch.reloadData()
        
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
extension ZTMovieSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTMovieCustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTMovieCustomTableViewCell, for: indexPath) as! ZTMovieCustomTableViewCell
        cell.selectionStyle = .none
        cell.loadMovieDetails(data: self.videosList?[indexPath.row], indexPath: indexPath)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let modelVal = self.videosList?[indexPath.row]{
            Helper.shared.goToMovieDetails(viewController: self, movieInfo: modelVal)
        }
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
    
}

extension ZTMovieSearchViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        self.searchMovies(txtSearch: textField.text ?? "")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringVal = NSString(string: textField.text!)
        let newText = stringVal.replacingCharacters(in: range, with: string)
        if newText.count >= 1{
            self.searchMovies(txtSearch: textField.text ?? "")
        }
        if newText.containsEmoji{
            return false
        }
        return true
    }
}

extension ZTMovieSearchViewController{
    func searchMovies(txtSearch:String){
        if txtSearch.count == 0{
            self.videosList?.removeAll()
            self.tblMovieSearch.reloadData()
        }else{
            if NetworkReachability.shared.isReachable{
                self.showActivityIndicator(self.tblMovieSearch)
                self.videosList?.removeAll()
                ZTCommonAPIWrapper.getbyMovieNameSearchUsingGET(movieName: self.removeWhiteSpace(text: txtSearch), pageNumber: self.pageNumber, pageSize: self.pageSize) { (response, error) in
                    self.hideActivityIndicator(self.view)
                    if error != nil{
                        WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                           
                        }, failureBlock: { (errorMsg) in
                           
                        })
                        return
                    }
                    if let responseVal = response{
                        self.videosList?.append(contentsOf: responseVal.content ?? [])
                        DispatchQueue.main.async {
                            self.tblMovieSearch.reloadData()
                        }
                    }
                }
                
            }
        }
    }
}
