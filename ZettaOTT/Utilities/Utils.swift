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
let colorRandom = [UIColor.init(netHex: 0xef7b1c), UIColor.init(netHex: 0xfbba0f), UIColor.init(netHex: 0x0a8dd2), UIColor.init(netHex: 0xc63838), UIColor.init(netHex: 0x98ba2f), UIColor.init(netHex: 0x7c52c6), UIColor.init(netHex: 0x49c0a1)]
//var isOverlayLoading: Bool = false
let loadingIndicator: ProgressView = {
    let progress = ProgressView(colors: [UIColor.getColor(colorVal: ZTGradientColor2), UIColor.white], lineWidth: 6)
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
extension Double {
    var string1: String {
        return String(format: "%.1f", self)
    }
    var string2: String {
        return String(format: "%.2f", self)
    }
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
    func getPriceValue() -> String{
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let usLocale = Locale.current
        formatter.locale = usLocale
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber (value:self)) ?? ""
    }

}
extension UIView {
    static let kLayerNameGradientBorder = "GradientBorderLayer"

    func gradientBorderLayer() -> CAGradientLayer? {
            let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
            if borderLayers?.count ?? 0 > 1 {
                fatalError()
            }
            return borderLayers?.first as? CAGradientLayer
        }
    func applyGradientEffect(isVertical: Bool, colorVal: UIColor) {
        let colorArray : [UIColor] = [ colorVal.withAlphaComponent(1.0), colorVal.withAlphaComponent(0.7),colorVal.withAlphaComponent(0.3), colorVal.withAlphaComponent(0.8),colorVal.withAlphaComponent(1.0) ]
        
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
    
        backgroundColor = .clear
        gradientLayer.frame = bounds
        
        let existedBorder = gradientBorderLayer()
        let border = existedBorder ?? CAGradientLayer()
        border.frame = bounds
        border.colors = colorArray.map { return $0.cgColor }
        border.startPoint = CGPoint(x: 0.0, y: 0.0)
        border.endPoint = CGPoint(x: 1.0, y: 1.0)
                
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = 10.0
        border.mask = mask
        layer.addSublayer(border)
        layer.insertSublayer(gradientLayer, at: 1)
        // Specify which corners to round
        let corners = UIRectCorner(arrayLiteral: [
            UIRectCorner.topLeft,
            UIRectCorner.topRight,
            UIRectCorner.bottomLeft,
            UIRectCorner.bottomRight
        ])

        // Determine the size of the rounded corners
        let cornerRadii = CGSize(
            width: 10.0,
            height: 10.0
        )

        // A mask path is a path used to determine what
        // parts of a view are drawn. UIBezier path can
        // be used to create a path where only specific
        // corners are rounded
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )

        // Apply the mask layer to the view
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = bounds

        layer.mask = maskLayer
    }
}
