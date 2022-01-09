//
//  ZTAppSession.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 04/11/21.
//

import UIKit

class ZTAppSession: NSObject {
    var userDefaults :UserDefaults
    class var sharedInstance: ZTAppSession {
        struct Static {
            static let instance = ZTAppSession()
        }
        return Static.instance
    }
    
    override init() {
        self.userDefaults = UserDefaults()
    }
    
    func saveValue() {
        self.userDefaults.synchronize()
    }
    
    func removeAllInstance()  {
        let defaults = userDefaults
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print(key)
            defaults.removeObject(forKey: key)
        }
    }
    func setUserInfo(data: AppUserModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            self.userDefaults.set(encoded, forKey: ZTUserDefaultKeys.AppUserModel)
        }
        self.saveValue()
    }
    func getUserInfo() -> AppUserModel? {
        if let keySettings = self.userDefaults.object(forKey: ZTUserDefaultKeys.LoginSuccessModel) as? Data {
            let decoder = JSONDecoder()
            if let appKey = try? decoder.decode(AppUserModel.self, from: keySettings){
                return appKey
            }
        }
        return nil
    }
    func setLoginInfo(data: LoginSuccessModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            self.userDefaults.set(encoded, forKey: ZTUserDefaultKeys.LoginSuccessModel)
        }
        self.saveValue()
    }
    func getLoginInfo() -> LoginSuccessModel? {
        if let keySettings = self.userDefaults.object(forKey: ZTUserDefaultKeys.LoginSuccessModel) as? Data {
            let decoder = JSONDecoder()
            if let appKey = try? decoder.decode(LoginSuccessModel.self, from: keySettings){
                return appKey
            }
        }
        return nil
    }
    func setVideoInfo(data: ContinueWatching) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            self.userDefaults.set(encoded, forKey: "ContinueWatching")
        }
        self.saveValue()
    }
    func getVideoInfo() -> ContinueWatching? {
        if let keySettings = self.userDefaults.object(forKey: "ContinueWatching") as? Data {
            let decoder = JSONDecoder()
            if let appKey = try? decoder.decode(ContinueWatching.self, from: keySettings){
                return appKey
            }
        }
        return nil
    }
    func setIsUserLoggedIn(_ value : Bool){
        self.userDefaults.set(value, forKey: "isUserLogin")
        self.saveValue()
        SwaggerClientAPI.customHeaders = WebServicesHelper().getHeaderDetails()
    }
    func getIsUserLoggedIn()->Bool{
        return self.userDefaults.bool(forKey: "isUserLogin")
    }
    func setIsRefreshUpdating(_ value : Bool){
        self.userDefaults.set(value, forKey: "RefreshToken")
        self.saveValue()
        SwaggerClientAPI.customHeaders = WebServicesHelper().getHeaderDetails()
    }
    func getIsRefreshUpdating()->Bool{
        return self.userDefaults.bool(forKey: "RefreshToken")
    }
    func setMovieLanguage(_ value : Int64){
        self.userDefaults.set(value, forKey: "MovieLanguage")
        self.saveValue()
    }
    func getMovieLanguage() -> Int64{
        return self.userDefaults.object(forKey: "MovieLanguage") as? Int64 ?? -1
    }
    func setIsSkipLoggedIn(_ value : Bool){
        self.userDefaults.set(value, forKey: "isSkipLogin")
        self.saveValue()
        SwaggerClientAPI.customHeaders = WebServicesHelper().getHeaderDetails()
    }
    func getIsSkipLoggedIn()->Bool{
        return self.userDefaults.bool(forKey: "isSkipLogin")
    }
    func setAccessToken (_ value: String) {
              
        self.userDefaults.set(value, forKey: "AccessToken")
        self.saveValue()
    }
  
    func getAccessToken ()-> String {
        let value: String? = self.userDefaults.object(forKey: "AccessToken") as? String
      
        return value ?? ""
    }
    
    func setSwaggerBasePath (_ value: String) {
              
        self.userDefaults.set(value, forKey: "BasePath")
        self.saveValue()
    }
  
    func getSwaggerBasePath ()-> String {
        let value: String? = self.userDefaults.object(forKey: "BasePath") as? String
        return value ?? ""
    }
    
}
