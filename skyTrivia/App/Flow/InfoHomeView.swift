//
//  InfoHomeView.swift
import Foundation
import UIKit
import SnapKit

class InfoHomeView: UIView {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgOther
        return imageView
    }()
 
    private (set) var backBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnBack, for: .normal)
        return btn
    }()
    
    private (set) var titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "Lockheed Vega"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Lockheed Vega")
        label.attributedText = attrString
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        label.textAlignment = .center
        return label
    }()
    
    private (set) var gradientBorderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private (set) var centerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgLockheedVega
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var bodyFieldInfo: UITextView = {
        let textView = UITextView()
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineBreakMode = .byWordWrapping
        textStyle.lineHeightMultiple = 1.13

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .author, style: .regular, size: 18),
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle
        ]
        
        let attributedText = NSAttributedString(string: "      The", attributes: attributes)
        textView.attributedText = attributedText
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.textColor = .white
        textView.isScrollEnabled = true
        return textView
    }()
    
    private (set) var gradientTextView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let quizBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.btnQuiz, for: .normal)
        button.setBackgroundImage(.btnQuizTapped, for: .highlighted)
        button.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 35
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupGradientBorder()
        setupGradientLayer()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    private func setupUI() {
        [bgImage, backBtn, titleLabel, gradientBorderView, centerImage, bodyFieldInfo, gradientTextView, quizBtn] .forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(56.autoSize)
            make.height.equalTo(56.autoSize)
            make.width.equalTo(64.autoSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(backBtn.snp.bottom).offset(24)
        }
        
        gradientBorderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.width.equalTo(353.autoSize)
            make.height.equalTo(258.autoSize)
        }
        
        centerImage.snp.makeConstraints { make in
            make.edges.equalTo(gradientBorderView).inset(2)
        }
        
        bodyFieldInfo.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(gradientBorderView.snp.bottom).offset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-72)
        }
        
        gradientTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(gradientBorderView.snp.bottom).offset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        quizBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupGradientBorder() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.cOrange.cgColor, UIColor.cOrangeTwo.cgColor, UIColor.cOrange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = gradientBorderView.bounds
        gradientLayer.cornerRadius = gradientBorderView.layer.cornerRadius
        
        gradientBorderView.layer.addSublayer(gradientLayer)
    }
    
    private func updateGradientFrame() {
        if let gradientLayer = gradientBorderView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientBorderView.bounds
        }
        gradientLayer?.frame = bodyFieldInfo.bounds
    }
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.withAlphaComponent(0.2).cgColor,
            UIColor.clear.withAlphaComponent(0.3).cgColor
        ]
        gradientLayer?.locations = [0.0, 0.5, 1.0]
        gradientLayer?.frame = gradientTextView.bounds
        gradientTextView.layer.insertSublayer(gradientLayer!, at: 0)
    }
}
