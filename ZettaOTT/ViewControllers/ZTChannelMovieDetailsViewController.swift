//
//  ZTChannelMovieDetailsViewController.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 14/02/22.
//

import UIKit
import CarbonKit

class ZTChannelMovieDetailsViewController: UIViewController {
    
    var zTChannelPayPerViewController: ZTChannelPayPerViewController?
    var zTChannelMoviePlaysViewController: ZTChannelMoviePlaysViewController?

    var carbonKitTabs:[String] = []
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    @IBOutlet weak var carbonKitView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    func initialLoad(){
        self.zTChannelMoviePlaysViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTChannelMoviePlaysViewController") as? ZTChannelMoviePlaysViewController
        
        self.zTChannelPayPerViewController = self.storyboard!.instantiateViewController(withIdentifier: "ZTChannelPayPerViewController") as? ZTChannelPayPerViewController
        self.carbonInitialize()
    }
    func carbonInitialize() {
        carbonKitTabs = ["Pay Per View", "Movie Plays"]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: carbonKitTabs as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.carbonKitView)
        self.style()
    }
    
    func style() {
        
        let color: UIColor = UIColor.getColor(colorVal: ZTAppWhiteColor)
        carbonTabSwipeNavigation.toolbar.isTranslucent = true
         carbonTabSwipeNavigation.toolbar.clipsToBounds = true
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.setTabBarHeight(40)
        carbonTabSwipeNavigation.toolbar.backgroundColor = UIColor.getColor(colorVal: ZTGradientColor1)
        carbonTabSwipeNavigation.setIndicatorHeight(2.0)
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor.getColor(colorVal: ZTGradientColor1)
        
        let frame  = (self.view.bounds.width  / CGFloat(self.carbonKitTabs.count))
 
        let font = UIFont.setAppFontMedium(16)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frame, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(frame, forSegmentAt: 1)

        carbonTabSwipeNavigation.setNormalColor(UIColor.getColor(colorVal: ZTGradientColor1), font: font )
        carbonTabSwipeNavigation.currentTabIndex = 0
        carbonTabSwipeNavigation.setSelectedColor(UIColor.getColor(colorVal: ZTAppWhiteColor), font: font)
        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK:- Carbon Kit delegates

extension ZTChannelMovieDetailsViewController: CarbonTabSwipeNavigationDelegate {

    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {

        case 0:
            return zTChannelPayPerViewController!
        case 1:
            return zTChannelMoviePlaysViewController!
        
        default:
            return zTChannelPayPerViewController!
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {

    }
}
