//
//  AppDelegate.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 30/09/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FacebookCore

var zt_minimumLineSpacing : CGFloat = 8
var zt_minimumInteritemSpacing : CGFloat = 8
var screenShotImage:UIImage? = nil
var mainNav : UINavigationController? = nil
var currentDeviceToken = String()
var model_name = String()
var model_number = String()
var os_type = String()
var os_version = String()
var app_build_no = String()
var app_version = String()
var device_uuid = String()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.portrait
    static var current: AppDelegate {
           return UIApplication.shared.delegate as! AppDelegate
       }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initialSetup()
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        SwaggerClientAPI.customHeaders = WebServicesHelper.shared.getHeaderDetails()

        self.setUpRoot()
        IQKeyboardManager.shared.enable = true
        NetworkReachability.shared.checkForReachability()
        return true
    }
    func initialSetup(){
        os_version = UIDevice.current.systemVersion
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String {
            
            app_version = String(format: "%@",text )
        }else{
            app_version = ""
        }
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String
        {
            app_build_no = String(format: "%@",buildNumber)

        }else{
            app_build_no = ""
        }
        if let device_Id = UIDevice.current.identifierForVendor?.uuidString{
            
            device_uuid = String(format: "%@",device_Id)
        }
        currentDeviceToken = ""
        model_name = UIDevice.current.name
        model_number = UIDevice.current.name
        
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    func setUpRoot() {
           if let _ = window{
               if ZTAppSession.sharedInstance.getIsSkipLoggedIn(){
                   Helper.shared.goToHomeScreen()
               }else{
                   if ZTAppSession.sharedInstance.getIsUserLoggedIn(){
                           Helper.shared.getUserBackground()
                           Helper.shared.goToHomeScreen()
                      }else{
                          let userLoggedIn = ZTAppSession.sharedInstance.getIsUserLoggedIn()
                          let tokenVal = ZTAppSession.sharedInstance.getAccessToken()
                          if tokenVal != "" && userLoggedIn == false{
                              Helper.shared.validateFirstLogin()
                          }else{
                              Helper.shared.goToLoginScreen()
                          }
                      }
               }
            
               window?.makeKeyAndVisible()
           }
       }
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        debugPrint("url\(url)")
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

extension UIWindow {
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
extension UIApplication {
    class func topViewController(_ base: UIViewController? = Helper.shared.getWindow()?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
