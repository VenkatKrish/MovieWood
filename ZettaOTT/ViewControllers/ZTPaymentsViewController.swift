//
//  ZTPaymentsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit
import StoreKit

class ZTPaymentsViewController: UIViewController {
    var subscriptionInfo:Subscriptions? = nil
    @IBOutlet weak var lblPlanName: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var stackLanguageTime: UIStackView!
    @IBOutlet weak var lblPrice: UILabel!   
    var isSubscription: Bool = true
    @IBOutlet weak var lblMovieLanguage: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieAge: UILabel!
    var moviewDetails : Movies? = nil
    @IBOutlet weak var lblSeperator: UILabel!
    var products: [SKProduct] = []
    var appUserModel:AppUserModel? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ZTPaymentsViewController.handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        // Do any additional setup after loading the view.
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: .IAPHelperPurchaseNotification, object: nil)
    }
    func initialLoad(){
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
            self.appUserModel = userModel
        }
        if self.isSubscription == true{
            self.stackLanguageTime.isHidden = true
//            self.lblSeperator.isHidden = true
            if let dataVal = subscriptionInfo{
                let duration:Int = Int(dataVal.subDuration ?? 0)
                self.lblPlanName.text = dataVal.name ?? ""
                self.lblDuration.text = String(format: "%d %@", duration, dataVal.uom ?? "")
                self.lblPrice.text = String(format: "%@", (dataVal.subValue ?? 0).getPriceValue())
            }
        }else{
            self.stackLanguageTime.isHidden = false
            if let movieInfo = self.moviewDetails{
                self.lblPlanName.text = movieInfo.movieName
                self.lblMovieLanguage.text = movieInfo.primaryLanguage
                if let movieTime = movieInfo.runningTime{
                   let convertToSec = Double(movieTime * 60)
                    let stringVal = convertToSec.asString(style: .short)
                    self.lblMovieDuration.text = stringVal.replacingOccurrences(of: ",", with: "")
                }
                self.lblMovieAge.text = String(format: "%d+", Int(movieInfo.ageRating ?? 0))
                self.lblMovieYear.text = String(format: "%d", Int(movieInfo.yearReleased ?? 0))
                self.lblPrice.text = String(format: "%@", (movieInfo.iosTicketPrice ?? 0).getPriceValue())
            }
        }
    }
    func getInAppProduct(){
        RazeFaceProducts.store.requestProducts{ [weak self] success, productsArr in
          guard let self = self else { return }
          if success {
            self.products = productsArr ?? []
              debugPrint("self.products \(productsArr)")
          }
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPayment(_ sender: Any) {
//        var productId = ""
//
//        if self.isSubscription == true{
//            productId = self.subscriptionInfo?.promoLabel ?? ""
//        }else{
//            productId = self.moviewDetails?.movieKey ?? ""
//        }
//        if productId.count > 0{
//            let productIdentifiers: Set<ProductIdentifier> = [productId]
//            RazeFaceProducts.store.productIdentifiers = productIdentifiers
//            self.getInAppProduct()
//        }
        self.placeOrder()
    }
    @objc func handlePurchaseNotification(_ notification: Notification) {
      guard
        let productID = notification.object as? String,
        let index = products.firstIndex(where: { product -> Bool in
          product.productIdentifier == productID
        })
      else { return }
    }
}
extension ZTPaymentsViewController{
    func placeOrder(){
        if NetworkReachability.shared.isReachable{
            self.showActivityIndicator(self.view)
            
            let bookingStart = Date()
            let startStr = Helper.shared.getFormatedDate(dateVal: bookingStart, dateFormat: CustomDateFormatter.orderRequestDate)
            let calendar = Calendar.current
            let bookingEnd = calendar.date(byAdding: .hour, value: 24, to: bookingStart)!
            
            let endStr = Helper.shared.getFormatedDate(dateVal: bookingEnd, dateFormat: CustomDateFormatter.orderRequestDate)
            
            let orders = Orders(bookingEndTime: endStr, bookingStartTime: startStr, capturedStatus: nil, conversionType: nil, couponCode: nil, createdBy: nil, createdOn: nil, discountPercentage: nil, discountType: nil, discountValue: nil, functionalCurrencyCode: "INR", lastUpdateLogin: nil, latitude: nil, longitude: nil, modifiedBy: nil, modifiedOn: nil, movieId: self.moviewDetails?.movieId ?? -1, movieOrderId: nil, orderCountry: "IN", orderDate: startStr, orderMovie: nil, orderNo: nil, orderQuantity: 1, orderRemarks: nil, orderSource: nil, orderType: nil, paidAmount: self.moviewDetails?.iosTicketPrice, paymentDate: startStr, paymentMode: "ApplePay", paymentStatus: MoviePaymentStatusStruct.paid.rawValue.uppercased(), paymentTransactionNo: "2070208254", subscriptionId: nil, taxPercentage: nil, totalOrderValue: self.moviewDetails?.iosTicketPrice ?? 0, totalRoundedValue: self.moviewDetails?.iosTicketPrice ?? 0, totalTaxValue: nil, transactionCurrencyCode: "USD", unitPrice: self.moviewDetails?.iosTicketPrice ?? 0, uom: "Nos", userId: Int64(self.appUserModel?.userId ?? -1), versionNumber: nil)
           
            ZTCommonAPIWrapper.saveMovieOrderUsingPOST(movieId: self.moviewDetails?.movieId ?? -1, order: orders) { response, error in
                self.hideActivityIndicator(self.view)
                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                       
                    }, failureBlock: { (errorMsg) in
                       
                    })
                    return
                }
                if let responseVal = response{
                    self.orderTransactionUpdate(orderDetails: responseVal)
                }
            }
        }
    }
    
    func orderTransactionUpdate(orderDetails:OrderConfirmation? = nil){
        if let orderConfirm = orderDetails{
            if NetworkReachability.shared.isReachable{
                self.showActivityIndicator(self.view)
                let paymentRequest = PaymentRequest(orderNo: orderDetails?.orderNo ?? "", paidAmount: orderConfirm.paidAmount ?? 0, paymentDate: orderDetails?.paymentDate ?? "", paymentMode: orderDetails?.paymentMode ?? "", paymentStatus: MoviePaymentStatusStruct.paid.rawValue, paymentTransactionNo: orderDetails?.paymentTransactionNo ?? "22323444", totalOrderValue: orderDetails?.totalOrderValue ?? 0, totalRoundedValue: orderDetails?.totalRoundedValue ?? 0, transactionCurrencyCode: orderDetails?.transactionCurrencyCode ?? "", unitPrice: orderDetails?.unitPrice ?? 0)
                
                
                ZTCommonAPIWrapper.updateOrderPayment(orderId: orderConfirm.movieOrderId ?? -1, paymentRequest: paymentRequest) { response, error in
                    self.hideActivityIndicator(self.view)
                    if error != nil{
                        WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in
                           
                        }, failureBlock: { (errorMsg) in
                           
                        })
                        return
                    }
                    if let responseVal = response{
                        Helper.shared.goToTicketConfirmationPage(viewController: self, subscriptionInfo: self.subscriptionInfo, movieInfo: self.moviewDetails, isSubscription: self.isSubscription, orderConfirmPayment: responseVal)
                    }
                }
            }
        }
        
    }
}
