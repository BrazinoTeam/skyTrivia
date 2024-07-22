//
//  GradientLabel.swift

import Foundation
import UIKit

class GradientLabel: UILabel {
    
    var gradientColors: [UIColor] = [.cBiegeGradOne, .cBiegeGradTwo]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = .center
        textLayer.frame = bounds
        textLayer.contentsScale = UIScreen.main.scale
        
        gradientLayer.mask = textLayer
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        layer.addSublayer(gradientLayer)
    }
}

class GradientLabelProfile: UILabel {
    
    var gradientColors: [UIColor] = [.cBiegeGradOne, .cBiegeGradTwo]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.font = font
        textLayer.fontSize = font.pointSize
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = .left
        textLayer.frame = bounds
        textLayer.contentsScale = UIScreen.main.scale
        
        gradientLayer.mask = textLayer
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        layer.addSublayer(gradientLayer)
    }
}

