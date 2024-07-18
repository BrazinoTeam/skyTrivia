//
//  InfoView.swift

import Foundation
import UIKit
import SnapKit

class InfoView: UIView {
    
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgOther
        return imageView
    }()
 
    private (set) var titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "info"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "info")
        label.attributedText = attrString

        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var containerInfo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgInfoCont
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private (set) var imgPlanes: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlanePoints
        imageView.contentMode = .scaleToFill
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 35
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
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
    
    private (set) var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to\nSkyTrivia!"
        label.font = .customFont(font: .sup, style: .ercharge, size: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private (set) var bodyLabel: UILabel = {
        let label = UILabel.createLabel(withText: "      SkyTrivia is an exciting game where you can\ntest your knowledge of aviation history and famous airplanes. Play quizzes, earn points, and compete with friends and other players around the world.\n\n       How to Play:\n  1. Study Information about Airplanes: On the\n      \"Info about plan\" page, you will find detailed\n      descriptions of each of the seven legendary \n      airplane models: Lockheed Vega, Beechcraft\n      Model 18, Piper PA-23 Apache, Cessna 310,\n      Beechcraft Baron, Cessna 402, and\n      Beechcraft King Air. Learn interesting facts \n      and historical data to better prepare for the\n      quizzes.\n  2. Participate in Quizzes: Go to the quiz page\n      where you will need to answer 10 questions.\n      Choose the correct answers, earn points,\n      and climb the leaderboard. If you correctly\n      answer 7 out of 10 questions, you will\n      receive bonus points and can return to the\n      home page with pride in your\n      achievements. In case of failure, you can\n      always return to the airplane information\n      and try again.\n  3. Receive Daily Bonuses: Visit the bonus page\n      every day and open one of the chests to get\n      extra points. This will help you progress\n      faster in the game and improve your results. \n  4. Track Your Progress: In your profile, you can\n      see your statistics, including the number of\n      completed quizzes, the number of points\n      earned, and your achievements. Customize\n      your profile by uploading an avatar and\n      changing your username.\n  5. Compete with Other Players: On the\n      leaderboard page, you can see the ranking\n      of the top players of the week. Compare\n      your results with other participants and\n      strive to become the top player of the\n      week.\n\n       Tips for Success:\n\n  \u{2022} Read Descriptions Carefully: On the airplane\n      information page, you will find all the\n      necessary data for successfully completing\n      the quizzes.\n  \u{2022} Use Bonuses: Daily bonuses will help you\n      earn points faster and progress in the game.\n  \u{2022} Play Regularly: The more you play, the more\n      chances you have to climb the leaderboard\n      and earn additional prizes.\n  \u{2022} Don't Give Up: If you didn't score enough\n      points in the quiz, go back to the airplane\n      information, refresh your knowledge, and\n      try again.\n      Enjoy the game and become a true aviation\n      expert!\n", font: .customFont(font: .author, style: .medium, size: 18), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.13, kern: 0.36)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
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

        [bgImage, titleLabel, containerInfo, imgPlanes, scrollView] .forEach(addSubview(_:))
        scrollView.addSubview(contentView)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(bodyLabel)

    }
    
    private func setupConstraints() {
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56.autoSize)
            make.left.right.equalToSuperview().inset(60)
        }
        
        containerInfo.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(72.autoSize)
            make.left.right.equalToSuperview()
        }
        
        imgPlanes.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(52.autoSize)
            make.centerX.equalToSuperview()
            make.height.equalTo(98)
            make.width.equalTo(89)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(containerInfo.snp.top).offset(64)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.left.right.equalToSuperview().inset(20)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20.autoSize)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }

}

