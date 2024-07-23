//
//  QuizOptionCell.swift

import UIKit
import SnapKit

class QuizOptionCell: UICollectionViewCell {
    
    private(set) var quizView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    private(set) var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .sup, style: .ercharge, size: 12)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private(set) var optionLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(font: .author, style: .medium, size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var gradientLayer: CAGradientLayer?
    private var backgroundGradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(quizView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(optionLabel)
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 6
    }
    
    private func setupConstraints() {
        quizView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(4)
            make.left.equalToSuperview().inset(4)
        }
        
        optionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(4)
        }
    }
    
    
    func configure(with variant: AirplaneModel.Airplane.Quiz.Question.Variant, at index: Int) {
        optionLabel.text = variant.text
        optionLabel.textColor = .white
        contentView.backgroundColor = .clear
        removeBackgroundGradient()
        removeGradientBorder()

        switch index {
        case 0:
            nameLabel.text = "A."
        case 1:
            nameLabel.text = "B."
        case 2:
            nameLabel.text = "C."
        case 3:
            nameLabel.text = "D."
        default:
            break
        }
    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            applyGradientBorder()
        } else {
            removeGradientBorder()
        }
    }
    
    func setCorrect(_ correct: Bool) {
        if correct {
            applyBackgroundGradient()
        } else {
            removeBackgroundGradient()
            contentView.layer.borderColor = UIColor.red.cgColor
            contentView.layer.borderWidth = 2
        }
    }
    
    private func applyGradientBorder() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.cBiegeGradOne.cgColor, UIColor.cBiegeGradTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = contentView.layer.cornerRadius
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 4
        shapeLayer.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        contentView.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        optionLabel.textColor = .cBiegeGradOne
    }
    
    private func removeGradientBorder() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
        optionLabel.textColor = .white
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.borderWidth = 2
    }
    
    private func applyBackgroundGradient() {
        removeBackgroundGradient()
        
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.colors = [UIColor.сGradGreenOne.cgColor, UIColor.сGradGreenTwo.cgColor]
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundGradientLayer.frame = contentView.bounds
        backgroundGradientLayer.cornerRadius = contentView.layer.cornerRadius
        
        contentView.layer.insertSublayer(backgroundGradientLayer, at: 0)
        self.backgroundGradientLayer = backgroundGradientLayer
    }
    
    private func removeBackgroundGradient() {
        backgroundGradientLayer?.removeFromSuperlayer()
        backgroundGradientLayer = nil
        contentView.backgroundColor = .clear
    }
}
