//
//  Utils.swift
//  ZettaOTT
//
//  Created by augusta-imac6 on 04/11/21.
//

import Foundation
import UIKit

var container: UIView = UIView()
var loadingView: CAShapeLayer = CAShapeLayer()
var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//var isOverlayLoading: Bool = false
let loadingIndicator: ProgressView = {
    let progress = ProgressView(colors: [UIColor.getColor(colorVal: ZTGradientColor2)], lineWidth: 6)
    progress.translatesAutoresizingMaskIntoConstraints = false
    return progress
}()

extension UIViewController{
    func removeSpecialCharsFromPhoneString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890")
        return String(text.filter {okayChars.contains($0) })
    }
    public func removeWhiteSpace(text:String) -> String
    {
        return text.trimmingCharacters(in: CharacterSet.whitespaces)
        
    }
    
    func showActivityIndicator(_ uiView: UIView, setDarkBackground: Bool! = true) {
        container.frame = uiView.bounds
        if setDarkBackground{
            container.backgroundColor = UIColor.init(netHex: 0x111111).withAlphaComponent(0.2)
        } else{
            container.backgroundColor = UIColor.clear
        }
        container.addSubview(loadingIndicator)
        uiView.addSubview(container)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: uiView.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: uiView.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 40),
            loadingIndicator.heightAnchor
                .constraint(equalTo: loadingIndicator.widthAnchor)
        ])
        
        loadingIndicator.isAnimating = true
    }
    
    public func hideActivityIndicator(_ uiView: UIView) {
        DispatchQueue.main.async {
            loadingIndicator.isAnimating = false
            container.removeFromSuperview()
        }
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
