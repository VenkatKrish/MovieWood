//
//  ProgressView.swift
//  CircularProgress
//
//  Created by Zafar on 10/3/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    // MARK: - Initialization
    init(frame: CGRect,
         colors: [UIColor],
         lineWidth: CGFloat
    ) {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        let path = UIBezierPath(ovalIn:
            CGRect(
                x: 0,
                y: 0,
                width: self.bounds.width,
                height: self.bounds.width
            )
        )
        shapeLayer.path = path.cgPath
        trackLayer.path = path.cgPath
        
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = nil
        
        let color = UIColor.getColor(colorVal: ZTGradientColor1)
        trackLayer.strokeColor = color.cgColor
        
    }
    
    // MARK: - Animations
    func animateStroke() {
        
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.0,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 3.0
        )
        
        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 2
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.repeatCount = MAXFLOAT
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation]
        
        //shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration
                //* Double(colors.count)
        )

//        shapeLayer.add(colorAnimation, forKey: nil)
        
        shapeLayer.add(animation, forKey: nil)
        
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(shapeLayer)

    }
    
    func animateRotation() {
        let rotationAnimation = RotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 3,
            repeatCount: .greatestFiniteMagnitude
        )
        
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    // MARK: - Properties
    let colors: [UIColor]
    let lineWidth: CGFloat
    
    private lazy var shapeLayer: ProgressShapeLayer = {
        return ProgressShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()
    
    
    let trackLayer = CAShapeLayer()

    
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animateStroke()
                self.animateRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
}
