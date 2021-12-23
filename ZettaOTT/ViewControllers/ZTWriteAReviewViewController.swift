//
//  ZTWriteAReviewViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 26/11/21.
//

import UIKit

protocol WriteAReviewDelegate{
    func updateUI()
}
class ZTWriteAReviewViewController: UIViewController {
    var moviewDetails : Movies? = nil
    var delegate : WriteAReviewDelegate? = nil
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblRatingVal: UILabel!
    @IBOutlet weak var txtVw: UITextView!
    var placeholderLabel : UILabel!
    var isReviewEdit:Bool = false
    var reviewDetails : MovieReviews? = nil
    var ratingVal:String = ""
    var user : AppUserModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
            self.user = userModel
        }
        self.customizedTextView()
        self.configureCosmos()
        // Do any additional setup after loading the view.
    }
    func customizedTextView(){
        self.txtVw.text = ""
        self.txtVw.layer.cornerRadius = 10.0
        self.txtVw.layer.borderColor = UIColor.getColor(colorVal: ZTReviewPageGreyColor).cgColor
        self.txtVw.layer.borderWidth = 0.5
        self.txtVw.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Your review"
        placeholderLabel.font = UIFont.setAppFontRegular((self.txtVw.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        self.txtVw.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.txtVw.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.getColor(colorVal: ZTReviewPageGreyColor)
        placeholderLabel.isHidden = !self.txtVw.text.isEmpty
        
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            self.delegate?.updateUI()
        })
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        let ratingComments = self.removeWhiteSpace(text: self.txtVw.text ?? "")
        if self.isValidationSuccess(ratingComments: ratingComments, ratingValStr: self.ratingVal) == true{
            self.createMoviewReview(ratingValue: self.ratingVal, ratingComments: ratingComments)
        }
    }
    func isValidationSuccess(ratingComments:String, ratingValStr:String) -> Bool {
        
        self.view.endEditing(true)
        var isValidationSuccess = true
        var message = ""
        
        if ratingComments.count == 0{
            message = ZTValidationMessage.REVIEW_REQUIRED
            isValidationSuccess = false
        }else if ratingValStr.count == 0{
            message = ZTValidationMessage.RATING_REQUIRED
            isValidationSuccess = false
        }
        if isValidationSuccess == false{
            Helper.shared.showSnackBarAlert(message: message, type: .Failure, superView: self)
        }
        return isValidationSuccess
    }
    func configureCosmos() {
        self.viewRating.starSize = 30
        self.viewRating.settings.updateOnTouch = true
        self.viewRating.settings.fillMode = .full
        self.viewRating.didFinishTouchingCosmos = { rating in
            print("Rating in swipe \(rating)")
            self.ratingVal = rating.string1
            self.lblRatingVal.text = self.ratingVal
        }
        self.viewRating.didTouchCosmos = { rating in
            self.ratingVal = rating.string1
            self.lblRatingVal.text = self.ratingVal
            print("Rating in touch \(rating)")
        }
    }
}
extension ZTWriteAReviewViewController{
    func createMoviewReview(ratingValue:String, ratingComments:String){
        if NetworkReachability.shared.isReachable {
            self.showActivityIndicator(self.view)
            let movieReviews = MovieReviews(active: nil, createdBy: nil, createdOn: nil, lastUpdateLogin: nil, modifiedBy: nil, modifiedOn: nil, movieId: self.moviewDetails?.movieId ?? -1, movieReviewId: nil, rating: ratingValue, reviewComments: ratingComments, user: nil, userId: self.user?.userId,versionNumber: nil)

            ZTCommonAPIWrapper.saveMovieReviewUsingPOST(movieId: self.moviewDetails?.movieId ?? -1, movieReview: movieReviews) { response, error in
                self.hideActivityIndicator(self.view)

                if error != nil{
                    WebServicesHelper().getErrorDetails(error: error!, successBlock: { (status, message, code) in

                    }, failureBlock: { (errorMsg) in

                    })
                    return
                }
                if let responseVal = response{
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: {
                            self.delegate?.updateUI()
                        })
                    }
                }
            }
            
        }
    }
}
extension ZTWriteAReviewViewController : UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let stringVal = NSString(string: textView.text!)
        let newText = stringVal.replacingCharacters(in: range, with: text)
        if newText.count <= Validation.REVIEW_LENGTH{
            return true
        }else{
            return false
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
    }
}
