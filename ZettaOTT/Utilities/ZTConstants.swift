//
//  ZTConstants.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 01/10/21.
//

import Foundation
import UIKit

let ZTScreenWidth = UIScreen.main.bounds.size.width
let ZTScreenHeight = UIScreen.main.bounds.size.height
let ACCEPTABLE_CHARACTERS_NAME = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ Ē"
let ACCEPTABLE_PHONENO = "0123456789"
let Web_About = "https://www.cinebazzar.com/about-us"
let Web_Terms = "https://www.cinebazzar.com/terms-and-conditions"
let Web_Privacy = "https://www.cinebazzar.com/privacy-policy"

struct Validation {
    static let FIRST_NAME_MAX = 100
    static let FIRST_NAME_MIN = 3
    static let EMAIL_MAX = 120
    static let LAST_NAME_MIN = 3
    static let LAST_NAME_MAX = 30
    static let PHONENO_MAX = 15
    static let AGE_MAX = 3
    static let REVIEW_LENGTH = 500

}
class SwaggerPathTypes {
//    static let Swagger_AuthService = "https://cholaott.cinebazzar.com/authentication"
//    static let Swagger_OtherService = "https://cholaott.cinebazzar.com/cholaottservice"
    
    
    // client server
    static let Swagger_AuthService = "https://ott.moviewood.io/authentication"
    static let Swagger_OtherService = "https://ott.moviewood.io/cholaottservice" 
    

}
class SocialAccountInfo {
//    static let Google_ClientId = "1031917031870-1ook6oe8p2jkov7ssl9f0p64gjkuee4b.apps.googleusercontent.com"
    //"460563733667-rb3gu4bomb4ioqqidt3c2b4ddpavbsh8.apps.googleusercontent.com"
    
    // client
    static let Google_ClientId = "562900447023-gj3opnf5dgl3v2ppalq6q4dgsnkv7793.apps.googleusercontent.com"
    
    
    
}
class LoginSource{
    static let mobileFlow = "mobile"
    static let emailFlow = "email"
    static let gmailFlow = "gmail"
    static let fbFlow = "facebook"

    
}
class ZTDefaultValues{
    static let Rupee_Symbol = "₹"
    static let placeholder_profile = "place_holder"
    static let placeholder_others = "place_holder"
    static let socialGmail = "gmail"
    static let defaultCountryCode = "IN"
//    static let imageBaseURL = "https://d13heh6lmag6t5.cloudfront.net"
    static let imageBaseURL = "https://d12roikjmrtrj5.cloudfront.net" // client

    static let dummyPwd = "123456789abcd"
}
class ZTValidationMessage{
    static let FIRST_NAME_REQUIRED = "First Name Required"
    static let LAST_NAME_REQUIRED = "Last Name Required"
    static let EMAIL_REQUIRED = "Email Required"
    static let AGE_REQUIRED = "Age Required"
    static let MOBILE_NUMBER_REQUIRED = "Mobile number required"
    static let INVALID_PHONE_NUMBER = "Invalid mobile number"
    static let INVALID_EMAIL = "Invalid email"
    static let INVALID_OTP = "Please enter OTP"
    static let GENDER_REQUIRED = "Gender Required"
    static let PROFILE_UPDATED = "Profile Updated"
    static let REVIEW_REQUIRED = "Review Required"
    static let RATING_REQUIRED = "Rating Required"

}

class ZTConstants: NSObject {
    static let BTN_READMORE = "Read More"
    static let BTN_READLESS = "Read Less"
    static let BTN_BOOK_NOW = "Book Now"
    static let BTN_BOOK_PLAY = "Watch Now"
    static let termsLabel = "By signing up, you are agreed with our Terms & Conditions"
    static let termsAndConditionLabel = "Terms & Conditions"
}

class ZTCellNameOrIdentifier{
    static let ZTPortraitVideoCollectionViewCell = "ZTPortraitVideoCollectionViewCell"
    static let ZTTypesOfVideosCollectionViewCell = "ZTTypesOfVideosCollectionViewCell"
    static let ZTHomeTableViewCell = "ZTHomeTableViewCell"
    static let ZTVideoHeaderTableViewCell = "ZTVideoHeaderTableViewCell"
    static let ZTVideoTypeTableViewCell = "ZTVideoTypeTableViewCell"
    static let ZTPagingTableViewCell = "ZTPagingTableViewCell"
    static let ZTContinueWatchingCollectionCell = "ZTContinueWatchingCollectionCell"
    static let ZTContinueWatchingCell = "ZTContinueWatchingCell"
    static let ZTProfileTopTableViewCell = "ZTProfileTopTableViewCell"
    static let ZTVideoTileCollectionViewCell = "ZTVideoTileCollectionViewCell"
    static let ZTProfileHeader = "ZTProfileHeader"
    static let ZTProfileFooter = "ZTProfileFooter"
    static let ZTMovieCustomTableViewCell = "ZTMovieCustomTableViewCell"
    static let ZTMovieInfoGenreCollectionViewCell = "ZTMovieInfoGenreCollectionViewCell"
    static let ZTCrewCollectionViewCell = "ZTCrewCollectionViewCell"
    static let ZTLanguageTableViewCell = "ZTLanguageTableViewCell"
    static let ZTPagingCollectionReusableView = "ZTPagingCollectionReusableView"
    static let ZTUserReviewTableViewCell = "ZTUserReviewTableViewCell"
    static let ZTPaymentCardCollectionViewCell = "ZTPaymentCardCollectionViewCell"
    static let ZTMyTransactionsTableViewCell = "ZTMyTransactionsTableViewCell"

}
class ZTControllerName{
    static let ZT_TabbarController = "ZTTabbarViewController"
    static let ZTHomeViewController = "ZTHomeViewController"
    static let ZTLoginViewController = "ZTLoginViewController"
    static let ZTSignupViewController = "ZTSignupViewController"
    static let ZTVerificationViewController = "ZTVerificationViewController"
    static let ZTMoviesListCategoryViewController = "ZTMoviesListCategoryViewController"
    static let ZTMovieSearchViewController = "ZTMovieSearchViewController"
    static let ZTMovieInfo1ViewController = "ZTMovieInfo1ViewController"
    static let ZTMovieInfo2ViewController = "ZTMovieInfo2ViewController"
    static let ZTMovieInfo3ViewController = "ZTMovieInfo3ViewController"
    static let ZTChooseAPlanViewController = "ZTChooseAPlanViewController"
    static let ZTPaymentsViewController = "ZTPaymentsViewController"
    static let ZTMovieDetailViewController = "ZTMovieDetailViewController"
    static let ZTProfileEditViewController = "ZTProfileEditViewController"
    static let ZTLanguageViewController = "ZTLanguageViewController"
    static let ZTHelpAndSupportViewController = "ZTHelpAndSupportViewController"
    static let ZTSettingsViewController = "ZTSettingsViewController"
    static let ZTAboutViewController = "ZTAboutViewController"
    static let ZTMyTransactionsViewController = "ZTMyTransactionsViewController"
    static let ZTMoviePlayerViewController = "ZTMoviePlayerViewController"
    static let ZTNowViewController = "ZTNowViewController"
    static let ZTUpcomingViewController = "ZTUpcomingViewController"
    static let ZTWebseriesViewController = "ZTWebseriesViewController"
    static let ZTShortFilmsViewController = "ZTShortFilmsViewController"
    static let ZTRatingsReviewsViewController = "ZTRatingsReviewsViewController"
    static let ZTWriteAReviewViewController = "ZTWriteAReviewViewController"
    static let ZTTickerConfirmationViewController = "ZTTickerConfirmationViewController"
    static let ZTCustomAlertViewController = "ZTCustomAlertViewController"

    
}
class moviesKeyUI {
    static let paging = "Paging"
    static let continue_watching = "Continue Watching"
    static let genres = "Genres"
    static let zetta_movies_originals = "Moviewood Originals"
    static let popular_movies = "Popular Movies"
    static let recommended = "Recommended"
    static let latest_tamil_movies = "Tamil Movies"
    static let latest_web_series = "Latest Web Series"

}
class ZTStoryBoardName{
    static let MAIN = "Main"
}
class ZTUserDefaultKeys {
    static let LoginSuccessModel = "LoginSuccessModel"
    static let AppUserModel = "AppUserModel"

}
class CustomDateFormatter{
    static let transactionDate = "dd MM"
    static let orderRequestDate = "dd-MM-yyyy HH:mm:ss"
}
class AlertTitle{
    static let logoutTitle = "Logout"
}
class AlertDescrition{
    static let logoutDesc = "Do you want to logout?"
}
class AlertButtons{
    static let YES = "YES"
    static let CANCEL = "Cancel"
}

