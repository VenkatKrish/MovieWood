//
//  ZTChooseAPlanViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 25/11/21.
//

import UIKit

class ZTChooseAPlanViewController: UIViewController {
    @IBOutlet weak var lblExclAmount: UILabel!
    @IBOutlet weak var lblExclDescription: UILabel!
    @IBOutlet weak var collectionSubscription: UICollectionView!
    var subscriptions : [Subscriptions]? = []
    var moviewDetails : Movies? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        self.collectionSubscription.collectionViewLayout = layout
        self.collectionSubscription.register(UINib(nibName: ZTCellNameOrIdentifier.ZTPaymentCardCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTPaymentCardCollectionViewCell)
        self.loadMovieDetails()
        self.loadSubscription()
    }
    func loadMovieDetails(){
        self.lblExclAmount.text = (self.moviewDetails?.iosTicketPrice ?? 0).getPriceValue()
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnProceed(_ sender: Any) {
        Helper.shared.goToPaymentPage(viewController: self, subscriptionInfo: nil, movieInfo: self.moviewDetails, isSubscription: false)
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
extension ZTChooseAPlanViewController{
    func loadSubscription(){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.allSubscription(pageNumber: 1, pageSize: 50, sortSorted : true ) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                        
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.subscriptions?.append(contentsOf: responseVal.content ?? [])
                    DispatchQueue.main.async {
                        self.collectionSubscription.reloadData()
                    }
                }
            }
        }
    }
}
extension ZTChooseAPlanViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subscriptions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTPaymentCardCollectionViewCell, for: indexPath) as! ZTPaymentCardCollectionViewCell
            cell.loadSubscriptionDetails(data: self.subscriptions?[indexPath.row], indexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
       
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
       
        return CGSize(width: widthPerItem, height: widthPerItem + 90)
    }
    
//    // inner margin
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataVal = self.subscriptions?[indexPath.row]{
            Helper.shared.goToPaymentPage(viewController: self, subscriptionInfo: dataVal, isSubscription:true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.size.width, height:50)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:1)
        }
}

