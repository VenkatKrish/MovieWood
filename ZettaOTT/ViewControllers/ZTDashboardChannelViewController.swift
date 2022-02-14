//
//  ZTDashboardChannelViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 14/02/22.
//

import UIKit

class ZTDashboardChannelViewController: UIViewController {
    @IBOutlet weak var collectionChannel: UICollectionView!
    var channelsList : [Channels]? = []
    var pageNumber : Int = 0
    var pageSize : Int = 50
    let spacing:CGFloat = 8.0
    let collectionHeight:CGFloat = 185.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func registerCells(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = zt_minimumLineSpacing
        layout.minimumInteritemSpacing = zt_minimumInteritemSpacing
        self.collectionChannel.collectionViewLayout = layout
//
//
//        self.profileCollection.register(UINib(nibName: ZTCellNameOrIdentifier.ZTProfileFooter, bundle: nil),
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
//                                withReuseIdentifier: ZTCellNameOrIdentifier.ZTProfileFooter)

        
        self.collectionChannel.register(UINib(nibName: ZTCellNameOrIdentifier.ZTChannelListCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ZTCellNameOrIdentifier.ZTChannelListCollectionViewCell)
    }
    func initialLoad(){
        self.getChannels()
    }
    func getChannels(){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            ZTCommonAPIWrapper.getMyChannelsUsingGET( pageNumber: self.pageNumber, pageSize: self.pageSize) { response, error in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.view)
                }
                if self.pageNumber == 0{
                    self.channelsList?.removeAll()
                }
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.channelsList?.append(contentsOf: responseVal.content ?? [])
                    self.refreshTable()
                }
            }
        }
    }
    func refreshTable(){
        self.collectionChannel.reloadData()
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
// MARK:- UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
extension ZTDashboardChannelViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channelsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.channelsList?[indexPath.row]{
            Helper.shared.goToChannelsMovieList(viewController: self, channelInfo: model)
        }

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZTCellNameOrIdentifier.ZTChannelListCollectionViewCell, for: indexPath) as! ZTChannelListCollectionViewCell
        cell.lblChannelName.text = self.channelsList?[indexPath.row].channelName ?? ""
        
        return cell
    }
    // minimum line margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // inner margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // margin between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
extension ZTDashboardChannelViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionHeight)
    }
}
