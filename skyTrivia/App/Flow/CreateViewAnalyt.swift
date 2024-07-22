//
//  CreateViewAnalyt.swift
import Foundation
import UIKit
import SnapKit

class CreateViewAnalyt: UIView {
    
    private(set) var imgBack: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgContAnalit
        return imageView
    }()
    
    private(set) var imgIcon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private (set) var titleLabel: GradientLabelProfile = {
        let label = GradientLabelProfile()
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .left
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var nameLabel: UILabel = {
        let label = UILabel.createLabel(withText: "create", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    init(frame: CGRect, image: UIImage, titleText: String, subTitleText: String) {
        super.init(frame: frame)
        imgIcon.image = image
        titleLabel.text = titleText
        nameLabel.text = subTitleText
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        [imgBack, imgIcon, titleLabel, nameLabel].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        imgBack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imgIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgIcon.snp.top).offset(8)
            make.left.equalTo(imgIcon.snp.right).offset(12)
            make.width.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.equalTo(imgIcon.snp.right).offset(12)
        }
    }
}

private extension NSMutableParagraphStyle {
    func apply(_ changes: (NSMutableParagraphStyle) -> Void) -> NSMutableParagraphStyle {
        changes(self)
        return self
    }
}
