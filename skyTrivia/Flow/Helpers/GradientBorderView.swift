//
//  GradientBorderView.swift

import Foundation
import UIKit

class GradientBorderView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()
    
    var gradientColors: [UIColor] = [UIColor.green, UIColor.red, UIColor.black] {
        didSet {
            updateGradientColors()
        }
    }
    
    var borderWidth: CGFloat = 2 {
        didSet {
            shapeLayer.lineWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = borderWidth
    }
    
    private func updateGradientColors() {
        gradientLayer.colors = gradientColors.map { $0.cgColor }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        shapeLayer.path = UIBezierPath(roundedRect: bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2), cornerRadius: layer.cornerRadius).cgPath
    }
}
