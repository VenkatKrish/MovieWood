//
//  ZTHomeViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 07/10/21.
//

import UIKit
import Alamofire
import SwiftUI
import CarbonKit


class ZTHomeViewController: UIViewController {
    @IBOutlet weak var segmentView: UIView!
    var carbonKitTabs:[String] = []
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var homeCarbonSelectedSegment: UInt = 0
    
    var zTNowViewController: ZTNowViewController?
    var zTUpcomingViewController: ZTUpcomingViewController?
    var zTWebseriesViewController: ZTWebseriesViewController?
    var zTShortFilmsViewController: ZTShortFilmsViewController?
    var zTStagePlaysViewController: ZTStagePlaysViewController?
    var zTDocumentoryViewController: ZTDocumentoryViewController?
    var zTMusicVideoViewController: ZTMusicVideoViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
    }
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        Helper.shared.goToMovieSearch(viewController: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view.takeScreenshot()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let userModel = ZTAppSession.sharedInstance.getUserInfo(){
        }
    }
    func initialLoad(){
        self.zTNowViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTNowViewController") as? ZTNowViewController
        self.zTUpcomingViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTUpcomingViewController") as? ZTUpcomingViewController
        self.zTWebseriesViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTWebseriesViewController") as? ZTWebseriesViewController
        self.zTShortFilmsViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTShortFilmsViewController") as? ZTShortFilmsViewController
        self.zTDocumentoryViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTDocumentoryViewController") as? ZTDocumentoryViewController
        self.zTMusicVideoViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTMusicVideoViewController") as? ZTMusicVideoViewController
        self.zTStagePlaysViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTStagePlaysViewController") as? ZTStagePlaysViewController
        
        self.carbonInitialize()
    }
}
extension ZTHomeViewController {
    
    func setUp(text: String, characterSpacing: Float)-> NSAttributedString{
           let attributedString = NSMutableAttributedString(string: text)
           attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
          return attributedString
    }

    func carbonInitialize() {
        carbonKitTabs = ["Now", "Upcoming", "Web Series",  "Short Films", "Documentory" , "Stage Plays", "Music Video"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: carbonKitTabs as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.segmentView)
        self.style()
    }
    
    func style() {
        
        let color: UIColor = UIColor.getColor(colorVal: ZTGradientColor1)
        carbonTabSwipeNavigation.toolbar.isTranslucent = true
         carbonTabSwipeNavigation.toolbar.clipsToBounds = true
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.setTabBarHeight(40)
        carbonTabSwipeNavigation.toolbar.backgroundColor = UIColor.getColor(colorVal: ZTFormBackgroundColor)
        carbonTabSwipeNavigation.setIndicatorHeight(2.0)
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor.getColor(colorVal: ZTFormBackgroundColor)
        
        let frame  = (self.view.bounds.width  / CGFloat(self.carbonKitTabs.count)) - 30
        let frameCat = (self.view.bounds.width / CGFloat(self.carbonKitTabs.count)) + 10
        
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frame, forSegmentAt: 0)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 1)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 2)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 3)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 4)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 5)
//        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frameCat, forSegmentAt: 6)

        
        let font = UIFont.setAppFontMedium(16)

        carbonTabSwipeNavigation.setNormalColor(UIColor.getColor(colorVal: ZTAppBlackColor), font: font )
        carbonTabSwipeNavigation.currentTabIndex = homeCarbonSelectedSegment
        carbonTabSwipeNavigation.setSelectedColor(UIColor.getColor(colorVal: ZTGradientColor1), font: font)
//        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = true
    }
    
}
// MARK:- Carbon Kit delegates

extension ZTHomeViewController: CarbonTabSwipeNavigationDelegate {

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {

        case 0:
            return zTNowViewController!
        case 1:
            return zTUpcomingViewController!
        case 2:
            return zTWebseriesViewController!
        case 3:
            return zTShortFilmsViewController!
        case 4:
            return zTDocumentoryViewController!
        case 5:
            return zTStagePlaysViewController!
        case 6:
            return zTMusicVideoViewController!
        default:
            return zTNowViewController!
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {

    }
}
