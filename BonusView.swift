//
//  BonusView.swift

import Foundation
import UIKit
import SnapKit

class BonusView: UIView {
    
    private (set) var bonusView: UIView = {
        let view = UIView()
        return view
    }()
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        return imageView
    }()
 
    private (set) var imgContPoints: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPointsCont
        return imageView
    }()
    
    private (set) var imgPlane: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlanePoints
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.642, blue: 0.311, alpha: 0.8).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 9
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private (set) var pointLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "\(MemoryApp.shared.scorePoints)"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "bonus"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "bonus".uppercased())
        label.attributedText = attrString

        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var subTitleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "Click on one of the\nSuitcases and get\na daily bonus"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private(set) var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            button.setImage(.imgSuitcase, for: .normal)
            button.tag = i
            buttons.append(button)
        }
        return buttons
    }()
    
    private (set) var timerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private (set) var timerBgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgHome
        return imageView
    }()
 
    private (set) var timerImgContPoints: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPointsCont
        return imageView
    }()
    
    private (set) var timerImgPlane: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlanePoints
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.642, blue: 0.311, alpha: 0.8).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 9
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private (set) var timerPointLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "\(MemoryApp.shared.scorePoints)"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var timerTitleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "bonus"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "bonus".uppercased())
        label.attributedText = attrString

        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var timerSubTitleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "The bonus will be\navailable through"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private (set) var timerCountTimeLabel: GradientLabel = {
        let label = GradientLabel()
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.gradientColors = [.cOrange, .cOrangeTwo, .cOrange]
        return label
    }()
    
    private (set) var imgAirplane: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgTimerBonus
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonTargets(target: Any, action: Selector) {
          buttons.forEach { button in
              button.addTarget(target, action: action, for: .touchUpInside)
          }
      }
    
    private func setupUI() {
        addSubview(bonusView)
        [bgImage, imgContPoints, titleLabel, subTitleLabel] .forEach(bonusView.addSubview(_:))
        imgContPoints.addSubview(imgPlane)
        imgContPoints.addSubview(pointLabel)
        buttons.forEach(bonusView.addSubview(_:))
        addSubview(timerView)
        [timerBgImage, timerImgContPoints, timerTitleLabel, timerSubTitleLabel, timerCountTimeLabel, imgAirplane] .forEach(timerView.addSubview(_:))
        timerImgContPoints.addSubview(timerImgPlane)
        timerImgContPoints.addSubview(timerPointLabel)

    }
    
    private func setupConstraints() {
        
        bonusView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imgContPoints.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(74.autoSize)
        }
        
        pointLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(80.autoSize)
        }
        
        imgPlane.snp.makeConstraints { make in
            make.centerY.equalTo(pointLabel)
            make.right.equalTo(pointLabel.snp.left).offset(-12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(imgContPoints.snp.bottom).offset(24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        let buttonWidth = 168
        let buttonHeight = 168
        let spacing = 16
           
        let totalWidth = (buttonWidth * 2) + spacing
        let horizontalOffset = (Int(UIScreen.main.bounds.width) - totalWidth) / 2
           
           for (index, button) in buttons.enumerated() {
               let row = index / 2
               let column = index % 2
               button.snp.makeConstraints { make in
                   make.width.equalTo(buttonWidth)
                   make.height.equalTo(buttonHeight)
                   make.top.equalTo(subTitleLabel.snp.bottom).offset(24 + (row * (buttonHeight + spacing)))
                   make.left.equalToSuperview().offset(horizontalOffset + (column * (buttonWidth + spacing)))
               }
           }
        
        timerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerBgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        timerImgContPoints.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(74.autoSize)
        }
        
        timerPointLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.width.equalTo(80.autoSize)
        }
        
        timerImgPlane.snp.makeConstraints { make in
            make.centerY.equalTo(pointLabel)
            make.right.equalTo(timerPointLabel.snp.left).offset(-12)
        }
        
        timerTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(timerImgContPoints.snp.bottom).offset(24)
        }
        
        timerSubTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(36)
            make.top.equalTo(timerTitleLabel.snp.bottom).offset(24)
        }
        
        timerCountTimeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(timerSubTitleLabel.snp.bottom).offset(12)
        }
        
        imgAirplane.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(timerTitleLabel.snp.bottom).offset(146)
        }
    }
}

