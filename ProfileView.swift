////
////  ProfileView.swift
//
//import Foundation
//import UIKit
//import SnapKit
//
//class ProfileView: UIView {
//    
//    
//    private (set) var bgImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = .bgHome
//        return imageView
//    }()
// 
//    private (set) var titleLabel: GradientLabel = {
//        let label = GradientLabel()
//        label.text = "profile"
//        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "profile")
//        label.attributedText = attrString
//
//        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
//        label.textAlignment = .center
//        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
//        return label
//    }()
//    
//    private (set) var imgUserPhoto: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = .imgUser
//        imageView.contentMode = .scaleToFill
//        imageView.layer.cornerRadius = 60
//        return imageView
//    }()
//    
//    private (set) var nameLabel: GradientLabel = {
//        let label = GradientLabel()
//        label.text = "username"
//        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
//        label.textAlignment = .center
//        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
//        return label
//    }()
//    
//    private (set) var btnName: UIButton = {
//        let btn = UIButton()
//        btn.setBackgroundImage(.btnName, for: .normal)
//        btn.setBackgroundImage(.btnNameSelect, for: .highlighted)
//        return btn
//    }()
//    
//    private (set) var btnPhoto: UIButton = {
//        let btn = UIButton()
//        btn.setBackgroundImage(.btnPhoto, for: .normal)
//        btn.setBackgroundImage(.btnPhotoSelect, for: .highlighted)
//        return btn
//    }()
//    
//    private (set) var analyticLabel: GradientLabel = {
//        let label = GradientLabel()
//        label.text = "Analytics"
//        label.font = .customFont(font: .sup, style: .ercharge, size: 24)
//        label.textAlignment = .center
//        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
//        return label
//    }()
//    
//    private (set) var analyticViewOne: CreateViewAnalyt = {
//        let view = CreateViewAnalyt(frame: .zero, image: .imgOneAchiv, titleText: "12345", subTitleText: "Number of quizzes\nsuccessfully completed")
//        return view
//    }()
//    
//    private (set) var analyticViewTwo: CreateViewAnalyt = {
//        let view = CreateViewAnalyt(frame: .zero, image: .imgTwoAchiv, titleText: "12345", subTitleText: "The number of\nuncompleted quizzes")
//        return view
//    }()
//    
//    private (set) var analyticViewThree: CreateViewAnalyt = {
//        let view = CreateViewAnalyt(frame: .zero, image: .imgThreeAchiv, titleText: "12345", subTitleText: "Number of points earned")
//        return view
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//
//        [bgImage, titleLabel, imgUserPhoto, nameLabel , btnName, btnPhoto, analyticLabel, analyticViewOne, analyticViewTwo, analyticViewThree] .forEach(addSubview(_:))
//
//    }
//    
//    private func setupConstraints() {
//     
//        bgImage.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(76.autoSize)
//            make.left.right.equalToSuperview().inset(60)
//        }
//        
//        imgUserPhoto.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(28)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(120)
//        }
//        
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(imgUserPhoto.snp.bottom).offset(16)
//            make.left.right.equalToSuperview().inset(60)
//
//        }
//        
//        btnName.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom)
//            make.centerX.equalToSuperview().offset(-92)
//        }
//        
//        btnPhoto.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom)
//            make.centerX.equalToSuperview().offset(92)
//        }
//        
//        analyticLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(112)
//            make.left.right.equalToSuperview().inset(60)
//        }
//        
//        analyticViewOne.snp.makeConstraints { make in
//            make.top.equalTo(analyticLabel.snp.bottom).offset(8)
//            make.left.right.equalToSuperview().inset(20)
//        }
//        
//        analyticViewTwo.snp.makeConstraints { make in
//            make.top.equalTo(analyticViewOne.snp.bottom).offset(8)
//            make.left.right.equalToSuperview().inset(20)
//        }
//        
//        analyticViewThree.snp.makeConstraints { make in
//            make.top.equalTo(analyticViewTwo.snp.bottom).offset(8)
//            make.left.right.equalToSuperview().inset(20)
//        }
//    }
//}
//
//
//  ProfileView.swift

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView {
    
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        return imageView
    }()
 
    private (set) var titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "profile"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "profile")
        label.attributedText = attrString

        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var imgUserPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgUser
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 60
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 35
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private (set) var nameLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "username"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var btnName: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnName, for: .normal)
        btn.setBackgroundImage(.btnNameSelect, for: .highlighted)
        return btn
    }()
    
    private (set) var btnPhoto: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnPhoto, for: .normal)
        btn.setBackgroundImage(.btnPhotoSelect, for: .highlighted)
        return btn
    }()
    
    private (set) var analyticLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "Analytics"
        label.font = .customFont(font: .sup, style: .ercharge, size: 24)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var analyticViewOne: CreateViewAnalyt = {
        let view = CreateViewAnalyt(frame: .zero, image: .imgOneAchiv, titleText: "12345", subTitleText: "Number of quizzes\nsuccessfully completed")
        return view
    }()
    
    private (set) var analyticViewTwo: CreateViewAnalyt = {
        let view = CreateViewAnalyt(frame: .zero, image: .imgTwoAchiv, titleText: "12345", subTitleText: "The number of\nuncompleted quizzes")
        return view
    }()
    
    private (set) var analyticViewThree: CreateViewAnalyt = {
        let view = CreateViewAnalyt(frame: .zero, image: .imgThreeAchiv, titleText: "12345", subTitleText: "Number of points earned")
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        [bgImage, titleLabel, imgUserPhoto, nameLabel , btnName, btnPhoto, scrollView] .forEach(addSubview(_:))
        
        scrollView.addSubview(contentView)
        [analyticLabel, analyticViewOne, analyticViewTwo, analyticViewThree] .forEach(contentView.addSubview(_:))
    }
    
    private func setupConstraints() {
     
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(76.autoSize)
            make.left.right.equalToSuperview().inset(60)
        }
        
        imgUserPhoto.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imgUserPhoto.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(60)
        }
        
        btnName.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(-92)
        }
        
        btnPhoto.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(92)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(btnName.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-52)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        analyticLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(60)
        }
        
        analyticViewOne.snp.makeConstraints { make in
            make.top.equalTo(analyticLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        analyticViewTwo.snp.makeConstraints { make in
            make.top.equalTo(analyticViewOne.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
        }
        
        analyticViewThree.snp.makeConstraints { make in
            make.top.equalTo(analyticViewTwo.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20) // Ensure contentView's bottom is constrained
        }
    }
}
