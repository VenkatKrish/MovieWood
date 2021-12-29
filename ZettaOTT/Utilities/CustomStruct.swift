//  CustomStruct.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import Foundation
import UIKit

public enum GlobalMediaType : Int {
       case image = 0
       case video = 1
        case unknown = 2
   }
enum FirstLogin : String {
    case None = ""
    case FirstLogin_YES = "Y"
    case FirstLogin_NO = "N"
    func FirstLogin() ->String{
        return self.rawValue
    }
}

enum StatusCodeObj : Int {
    case Unauthorised = 401
    case forbidden = 403
    case badrequest = 400
    case success201 = 201
    case success200 = 200
    func StatusCodeObj() -> Int{
        return self.rawValue
    }
}
enum MovieSearchTag : String {
    case movieSearchAvg = "avgRating>3,active:Y,showInIos:Y"
    case zettaMovieOriginal = "movieType:Movie,active:Y,showInIos:Y"
    case shortFilms = "movieType:Shorts,active:Y,showInIos:Y"
    case webSeries = "movieType:Series,active:Y,showInIos:Y"
    case genresFilter = "active:Y,showInIos:Y,movieGenresDSgenreIdLIST="
    case latestTamilMovies = "active:Y,showInIos:Y,primaryLanguage:Tamil"
    case streamNow = "contenttype=Movie"
    case streamNowWebseries = "contenttype=Series"
    case streamNowShortFilms = "contenttype=Shorts"

    func MovieSearchTag() -> String{
        return self.rawValue
    }
}

enum WebViewStrings : String {
    case about = "about-us"
    case privacy = "privacy-policy"
    case terms = "Terms-And-Conditions"
    case title_about = "About"
    case title_privacy = "Privacy Policy"
    case title_terms = "Terms & Condition"
    func WebViewStrings() -> String{
        return self.rawValue
    }
}
enum MovieOrderStatusStruct : String {
    case paid = "PAID"
    case new = "NEW"
    case cancelled = "CANCELLED"
    func MoviePaymentStatusStruct() -> String{
        return self.rawValue
    }
}
enum SubscriptionUom : String {
    case days = "Days"
    case year = "Year"
    case month = "Month"
    func SubscriptionUom() -> String{
        return self.rawValue
    }
}
enum MovieOrderTypeStruct : String {
    case subscription = "Subscription"
    case payPerView = "PayPerView"
    func MovieOrderTypeStruct() -> String{
        return self.rawValue
    }
}

enum MoviePaymentStatusStruct : String {
    case paid = "1"
    case none = "0"
    func MoviePaymentStatusStruct() -> String{
        return self.rawValue
    }
}

enum TransactionStatusStruct : String {
    case Success = "Success"
    case New = "New"
    case Failure = "Failure"
    func TransactionStatusStruct() -> String{
        return self.rawValue
    }
}

struct MovieCollectionUI{
    var collectionName : String?
    var moviesList: [Movies]?
}
struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
enum AlertViewType{
    case Logout
    case CameraPermission
}


public struct ContinueWatching: Codable {

    var movieId:Int64?
    var userIdVal:Int64?
    var overAllSecond : Double?
    var watchedSecond : Double?

    public init(movieId: Int64?, userIdVal: Int64?, overAllSecond: Double?, watchedSecond: Double?) {
        self.movieId = movieId
        self.userIdVal = userIdVal
        self.overAllSecond = overAllSecond
        self.watchedSecond = watchedSecond
    }

}
