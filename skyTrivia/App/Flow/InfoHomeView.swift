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
        imageView.contentMode = .scaleToFill
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
        
        let attributedText = NSAttributedString(string: "      The Lockheed Vega is an iconic aircraft that played a significant role in the history of aviation. First designed by Lockheed in 1927, the Vega was intended as a high-performance, long-range aircraft. Its design featured a cantilever wing, which eliminated the need for struts, contributing to its sleek, aerodynamic shape. The aircraft was built with a wooden fuselage covered in plywood, which provided strength while keeping the weight down. The Vega could carry up to six passengers and was initially powered by a 450-horsepower Pratt & Whitney Wasp radial engine, giving it a maximum speed of approximately 135 miles per hour and a range of around 700 miles.\nThe Vega gained fame for its involvement in several notable flights and records. One of the most famous Vegans, the \"Winnie Mae,\" was flown by Wiley Post, who set a record for flying around the world solo in 1933. The aircraft also played a crucial role in Amelia Earhart's historic transatlantic solo flight in 1932, making her the first woman to achieve this feat. These record-breaking flights showcased the Vega's reliability, endurance, and advanced design for its time.\nBesides its record-breaking flights, the Vega was used in various roles, including mail delivery, exploration, and air racing. It was renowned for its ruggedness and ability to operate in harsh conditions, which made it a favorite among pilots who required a dependable and versatile aircraft. The Vega's design and performance left a lasting legacy in aviation history, influencing subsequent aircraft designs and cementing its place as a pioneering model in the evolution of aviation.\n", attributes: attributes)
        textView.attributedText = attributedText
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.textColor = .white
        return textView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupGradientBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }
    
    private func setupUI() {
        [bgImage, backBtn, titleLabel, gradientBorderView, centerImage, bodyFieldInfo, quizBtn] .forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(56.autoSize)
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
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-48)
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
    }
}
