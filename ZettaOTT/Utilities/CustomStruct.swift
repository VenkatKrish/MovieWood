//  CustomStruct.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import Foundation
import UIKit

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
    case movieSearchAvg = "avgRating>3"
    case zettaMovieOriginal = "movieType:Movie"
    case shortFilms = "movieType:Shorts"
    case webSeries = "movieType:Series"
    case genresFilter = "movieGenresDSgenreIdLIST="    
//    case latestTamilMovies = "avgRating>3"
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
enum MoviePaymentStatusStruct : String {
    case paid = "PAID"
    case new = "NEW"
    case cancelled = "CANCELLED"
    func MoviePaymentStatusStruct() -> String{
        return self.rawValue
    }
}

enum TransactionStatusStruct : String {
    case Success = "Success"
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
