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
    var selectedProdcutId: String = ""
    var skProductVal: SKProduct? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)

        self.initialLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ZTPaymentsViewController.handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        // Do any additional setup after loading the view.
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: .IAPHelperPurchaseNotification, object: nil)
        SKPaymentQueue.default().remove(self)
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
              DispatchQueue.main.async {
                  if self.products.count > 0{
                      self.showActivityIndicator(self.view)
                      RazeFaceProducts.store.buyProduct(self.products[0])
                  }else{
//                      self.placeOrder(product: nil, transaction: nil)
                  }
              }
              
          }else{
//              self.placeOrder(product: nil, transaction: nil)
          }
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnPayment(_ sender: Any) {
        var productId = ""

        if self.isSubscription == true{
            self.selectedProdcutId = self.subscriptionInfo?.subsKey ?? ""
            productId = self.subscriptionInfo?.subsKey ?? ""

        }else{
            self.selectedProdcutId = self.moviewDetails?.movieKey ?? ""
            productId = self.moviewDetails?.movieKey ?? ""

        }
        self.showActivityIndicator(self.view)
        self.requestInApp()
        
//        if productId.count > 0{
//            let productIdentifiers: Set<ProductIdentifier> = [productId]
//            RazeFaceProducts.productIdentifiers = productIdentifiers
////            RazeFaceProducts.store.productIdentifiers = productIdentifiers
//            self.getInAppProduct()
//        }
//        self.placeOrder()
        
    }
    func requestInApp(){
        if (SKPaymentQueue.canMakePayments()) {
            let productID:NSSet = NSSet(object: self.selectedProdcutId);
            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
                productsRequest.delegate = self;
                productsRequest.start();
            print("Fetching Products");
            } else {
                print("can't make purchases");
            }
    }
    @objc func handlePurchaseNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            self.hideActivityIndicator(self.view)
        }

        if let inAppProductTransaction = notification.object as? InAppProductTransaction{
            var transactionErrorStr = ""
            if let transactionError = inAppProductTransaction.transaction?.error as NSError?,
               let localizedDescription = inAppProductTransaction.transaction?.error?.localizedDescription,
                transactionError.code != SKError.paymentCancelled.rawValue {
                
                transactionErrorStr = "\(localizedDescription)"
                print("Transaction Error: \(localizedDescription)")
            }else{
                let productVal = self.products.first(where: { $0.productIdentifier == inAppProductTransaction.productIdentifier })
                    
                self.placeOrder(product: productVal, transaction: inAppProductTransaction.transaction ?? nil, isFailed: true)
            }
        }
    }
}
extension ZTPaymentsViewController{
    func placeOrder(product:SKProduct?, transaction:SKPaymentTransaction?, isFailed:Bool){
        if NetworkReachability.shared.isReachable{
            
            self.showActivityIndicator(self.view)
            var endStr = ""
            let calendar = Calendar.current

            let bookingStart = Date()
            var bookingEnd = Date()

//            bookingStart = calendar.date(byAdding: .day, value: -1, to: Date())!
            
            let startStr = Helper.shared.getFormatedDate(dateVal: bookingStart, dateFormat: CustomDateFormatter.orderRequestDate)
            
            var movieID:Int64 = 0
            var paidAmount:Double = 0

            if self.isSubscription == true{
                movieID = 0
                paidAmount = self.subscriptionInfo?.subValue ?? 0
                if self.subscriptionInfo?.uom ?? "" == SubscriptionUom.days.rawValue{
                    bookingEnd = calendar.date(byAdding: .day, value: self.subscriptionInfo?.subDuration ?? 0, to: bookingStart)!
                    
                }else if self.subscriptionInfo?.uom ?? "" == SubscriptionUom.year.rawValue{
                    bookingEnd = calendar.date(byAdding: .year, value: self.subscriptionInfo?.subDuration ?? 0, to: bookingStart)!
                }else{
                    bookingEnd = calendar.date(byAdding: .month, value: self.subscriptionInfo?.subDuration ?? 0, to: bookingStart)!
                }
            }else{
                paidAmount = self.moviewDetails?.iosTicketPrice ?? 0
                movieID = self.moviewDetails?.movieId ?? 0
                bookingEnd = calendar.date(byAdding: .hour, value: 24, to: bookingStart)!
            }
            endStr = Helper.shared.getFormatedDate(dateVal: bookingEnd, dateFormat: CustomDateFormatter.orderRequestDate)
            
            var transactionErrorStr = ""
            if let transactionError = transaction?.error as NSError?,
               let localizedDescription = transaction?.error?.localizedDescription,
                transactionError.code != SKError.paymentCancelled.rawValue {
                
                transactionErrorStr = "\(localizedDescription)"
                print("Transaction Error: \(localizedDescription)")
              }
            
            var orderCountry = "IN"
            var transactionCurrencyCode = "USD"
            if let productVal = product {
                orderCountry = productVal.priceLocale.regionCode ?? "IN"
                transactionCurrencyCode = productVal.priceLocale.currencyCode ?? "USD"
                paidAmount = productVal.price.doubleValue
            }
            
            var transactionNo = "8578575858"
            if let transactionVal = transaction {
                transactionNo = transactionVal.transactionIdentifier ??  "8578575858"
            }
            
            var orders = Orders.init()
        
            if isSubscription == true{
                orders = Orders(bookingEndTime: endStr, bookingStartTime: startStr, capturedStatus: nil, conversionType: nil, couponCode: nil, createdBy: nil, createdOn: nil, discountPercentage: nil, discountType: nil, discountValue: nil, functionalCurrencyCode: "INR", lastUpdateLogin: nil, latitude: nil, longitude: nil, modifiedBy: nil, modifiedOn: nil, movieId: movieID, movieOrderId: nil, orderCountry: orderCountry, orderDate: startStr, orderMovie: nil, orderNo: nil, orderQuantity: 1, orderRemarks: transactionErrorStr, orderSource: "iOS", orderType: MovieOrderTypeStruct.subscription.rawValue, paidAmount: paidAmount, paymentDate: startStr, paymentMode: "ApplePay", paymentStatus: MovieOrderStatusStruct.paid.rawValue, paymentTransactionNo: transactionNo, subscriptionId: self.subscriptionInfo?._id, taxPercentage: nil, totalOrderValue: self.subscriptionInfo?.subValue, totalRoundedValue: self.subscriptionInfo?.subValue, totalTaxValue: nil, transactionCurrencyCode: transactionCurrencyCode, unitPrice: self.subscriptionInfo?.subValue, uom: "Nos", userId: Int64(self.appUserModel?.userId ?? -1), versionNumber: nil) //
            }else{
                orders = Orders(bookingEndTime: endStr, bookingStartTime: startStr, capturedStatus: nil, conversionType: nil, couponCode: nil, createdBy: nil, createdOn: nil, discountPercentage: nil, discountType: nil, discountValue: nil, functionalCurrencyCode: "INR", lastUpdateLogin: nil, latitude: nil, longitude: nil, modifiedBy: nil, modifiedOn: nil, movieId: movieID, movieOrderId: nil, orderCountry: orderCountry, orderDate: startStr, orderMovie: nil, orderNo: nil, orderQuantity: 1, orderRemarks: transactionErrorStr, orderSource: "iOS", orderType: MovieOrderTypeStruct.payPerView.rawValue, paidAmount: paidAmount, paymentDate: startStr, paymentMode: "ApplePay", paymentStatus: MovieOrderStatusStruct.paid.rawValue, paymentTransactionNo: transactionNo, subscriptionId: nil, taxPercentage: nil, totalOrderValue: self.moviewDetails?.iosTicketPrice ?? 0, totalRoundedValue: self.moviewDetails?.iosTicketPrice ?? 0, totalTaxValue: nil, transactionCurrencyCode: transactionCurrencyCode, unitPrice: self.moviewDetails?.iosTicketPrice ?? 0, uom: "Nos", userId: Int64(self.appUserModel?.userId ?? -1), versionNumber: nil)
            }
//            transactionCurrencyCode and paid amount, order country, transaction number
            ZTCommonAPIWrapper.saveMovieOrderUsingPOST(movieId: movieID, order: orders) { response, error in
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
        if let orderConfirm = orderDetails{ // order paymentStatus need to change based on InApp purchase fail or success and need to update order remarks text from apple purchase failure reason
            
            if NetworkReachability.shared.isReachable{
                self.showActivityIndicator(self.view)
                let paymentRequest = PaymentRequest(orderNo: orderDetails?.orderNo ?? "", paidAmount: orderConfirm.paidAmount ?? 0, paymentDate: orderDetails?.paymentDate ?? "", paymentMode: orderDetails?.paymentMode ?? "", paymentStatus: MovieOrderStatusStruct.paid.rawValue, paymentTransactionNo: orderDetails?.paymentTransactionNo ?? "22323444", totalOrderValue: orderDetails?.totalOrderValue ?? 0, totalRoundedValue: orderDetails?.totalRoundedValue ?? 0, transactionCurrencyCode: orderDetails?.transactionCurrencyCode ?? "", unitPrice: orderDetails?.unitPrice ?? 0)
                
                
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

extension ZTPaymentsViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    func buyProduct(product: SKProduct) {
        DispatchQueue.main.async {
            self.showActivityIndicator(self.view)
        }
        debugPrint("Sending the Payment Request to Apple");
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment);
    }
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.hideActivityIndicator(self.view)
        }
        let count : Int = response.products.count
        if (count > 0) {
            let validProduct: SKProduct = response.products[0] as SKProduct
            if (validProduct.productIdentifier == self.selectedProdcutId) {
                self.skProductVal = validProduct
                print(validProduct.localizedTitle)
                print(validProduct.localizedDescription)
                print(validProduct.price)
                buyProduct(product: validProduct);
            } else {
                print(validProduct.productIdentifier)
            }
        } else {
            DispatchQueue.main.async {
                Helper.shared.showSnackBarAlert(message: "No products found", type: .Failure, superView: self)
            }
            print("nothing")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");
        DispatchQueue.main.async {
            self.hideActivityIndicator(self.view)
        }
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                
                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased");
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(self.view)
                    }
                    SKPaymentQueue.default().finishTransaction(trans)
                    if let productVal = self.skProductVal{
                        self.placeOrder(product: productVal, transaction: trans, isFailed: false)
                    }
                    break;
                case .failed:
                   
                    print("Purchased Failed");
                    
                    var transactionErrorStr = ""
                    if let transactionError = trans.error as NSError?,
                       let localizedDescription = trans.error?.localizedDescription,
                        transactionError.code != SKError.paymentCancelled.rawValue {
                        
                        transactionErrorStr = "\(localizedDescription)"
                        print("Transaction Error: \(localizedDescription)")
                      }
                    
                    DispatchQueue.main.async {
                        Helper.shared.showSnackBarAlert(message: "Transaction failed", type: .Failure, superView: self)
                    }
                    SKPaymentQueue.default().finishTransaction(trans)
//                    if let productVal = self.skProductVal{
//                        self.placeOrder(product: productVal, transaction: trans, isFailed: true)
//                    }
                    break;
                case .restored:
                    print("Already Purchased");
                    SKPaymentQueue.default().restoreCompletedTransactions()
                case .purchasing:
                    DispatchQueue.main.async {
                        self.showActivityIndicator(self.view)
                    }
                default:
                    break;
                }
            }
        }
    }
    
    private func request(request: SKRequest!, didFailWithError error: NSError!) {
        print("Error Fetching product information");
    }
}
