//
//  WebServicesHelper.swift
//  UBIQUIFIT
//
//  Created by Augusta MAc on 03/08/18.
//  Copyright © 2018 Anand-iMac. All rights reserved.
//

import UIKit

typealias kSuccessBlockWithObject = (_ success : Bool, _ response : Any) ->()

typealias kSuccessBlock = (_ success : Bool, _ message : [String: AnyObject],_ code: Int) ->()
typealias kErrorBlock = (_ errorMesssage: String) -> ()
typealias kSuccessWithMessageCodeBlock = (_ success: Bool, _ messageCode: Int, _ message: String) ->()

typealias kCommonAPISuccessWithMessageCodeBlock = (_ success: Bool, _ messageCode: Int, _ message: String) ->()
typealias kCommonAPIFailureWithMessageCodeBlock = (_ messageCode: Int, _ message: String) ->()

typealias kimageVideoSuccessBlock = (_ success: Bool) ->()
typealias kimageVideoFailureBlock = (_ success: Bool) ->()
typealias ksupportAccountFailureBlock = (_ errorMessage : String,_ message:Int) ->()

typealias kImageLoaderSuccessFailure = (_ success: Bool,_ imageValHeight: CGFloat,_ error:String) ->()

let CommonErrorMessage = "Oops !!!! Something went wrong and our developers are notified"
let CommonErrorCode = 10000

class WebServicesHelper: NSObject {
    var selfViewAlertType: String = ""
    var keyArray = ["error", "message", "token", "password"]
    class var shared: WebServicesHelper {
        struct Static {
            static let instance: WebServicesHelper = WebServicesHelper()
        }
        return Static.instance
    }
    /// Login Headers
    ///
    /// - Returns: String:String type
    func getLoginHeaderDetails() -> [String:String]
    {
        let headers = ["Content-Type": "application/json"]
        return headers
    }
    
    /// Default Headers
    ///
    /// - Returns: String:String type
    func getDefaultHeaderDetails() -> [String:String]
    {
        let token = "Bearer \(ZTAppSession.sharedInstance.getAccessToken())"
        
        let headers = ["Content-Type": "application/json", "Authorization":token]
        return headers
    }
    
    func getHeaderDetails(supportUserLoggedIn:Bool? = false) ->  [String:String]
    {
        var header:[String:String]!
        
//        if Helper.shared.isKeyPresentInUserDefaults(key: "isUserLogin") == false && ZTAppSession.sharedInstance.getIsUserLoggedIn() == false{
//            header = getLoginHeaderDetails()
//        }
//        else{
//            header = getDefaultHeaderDetails()
//        }
//        debugPrint("header\(header)")
//        return header
        
        if Helper.shared.isKeyPresentInUserDefaults(key: "isUserLogin") == false && ZTAppSession.sharedInstance.getIsUserLoggedIn() == false{
            header = getLoginHeaderDetails()
        }
        else{
            header = getDefaultHeaderDetails()
        }
        debugPrint("header\(header)")
        return header
    }
    
    func getErrorDetails(error: Error,
                         successBlock: @escaping kSuccessBlock,
                         failureBlock : @escaping kErrorBlock){
        
        if let err = error as? ErrorResponse {
            debugPrint(err)
            switch(err){
            case .error(401, _, _):
                break
//            case .error(403, _, _):
//                break
            case .error(let statusCode, let data, _):
                if let responseData = data {
                    if let jsonObject = try? (JSONSerialization.jsonObject(with: responseData, options: []) as! [String: AnyObject])
                    {
                        successBlock(true,jsonObject,statusCode)
                    }
                    else{
                        failureBlock(CommonErrorMessage)
                    }
                }
                else{
                    failureBlock(CommonErrorMessage)
                }
                
                break
            }
        }
    }
}
