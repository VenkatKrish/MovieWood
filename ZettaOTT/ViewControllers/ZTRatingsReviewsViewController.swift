//
//  ZTRatingsReviewsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

class ZTRatingsReviewsViewController: UIViewController {
    @IBOutlet weak var tblReviews: UITableView!
    var moviewReviews : [MovieReviews]? = []
    var moviewDetails : Movies? = nil
    var isPageEnable: Bool = true
    var pageSize : Int = 50
    var pageNumber : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnWriteAReview(_ sender: Any) {
        
    }
    func initialLoad(){
        self.tblReviews.rowHeight = UITableView.automaticDimension
        self.tblReviews.estimatedRowHeight = 100
        self.tblReviews.isScrollEnabled = false
        self.tblReviews.register(UINib(nibName: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, bundle: nil), forCellReuseIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell)
        self.loadReviews()
    }
    func loadReviews(){
        self.pageNumber = 0
        self.getMovieReviews(isSpinnerNeeded:true)
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
extension ZTRatingsReviewsViewController{
    func getMovieReviews(isSpinnerNeeded:Bool){
        if NetworkReachability.shared.isReachable {
            if isSpinnerNeeded == true{
                self.showActivityIndicator(self.view)
            }
            ZTCommonAPIWrapper.movieReviewsByMovie(movieId: self.moviewDetails?.movieId ?? -1) { response, error in
                if isSpinnerNeeded == true{
                    self.hideActivityIndicator(self.view)
                }
                if self.pageNumber == 0{
                    self.moviewReviews?.removeAll()
                }
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.moviewReviews?.append(contentsOf: responseVal.content ?? [])
                    if responseVal.last == true{
                        self.isPageEnable = false
                    }
                    DispatchQueue.main.async {
                        self.tblReviews.reloadData()
                    }
                }
            }
        }
    }
}
//TableView Delegate
extension ZTRatingsReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviewReviews?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ZTUserReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZTCellNameOrIdentifier.ZTUserReviewTableViewCell, for: indexPath) as! ZTUserReviewTableViewCell
        cell.selectionStyle = .none
        cell.loadReviews(data: self.moviewReviews?[indexPath.row], indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isPageEnable == true {
            if   indexPath.row ==  self.moviewReviews?.count ?? 0 - 1 {
                debugPrint(indexPath.row)
                self.pageNumber = self.pageNumber + 1
                self.getMovieReviews(isSpinnerNeeded: false)
            }
        }
    }
}
