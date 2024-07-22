//
//  LeaderCell.swift

import Foundation
import UIKit
import SnapKit

class LeaderCell: UITableViewCell {
    
    static let reuseId = String(describing: LeaderCell.self)

    private(set) lazy var numberLabel: UILabel = {
        let label = UILabel.createLabel(withText: "1", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1, kern: 3)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgUserLead
        return iv
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel.createLabel(withText: "1", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1, kern: 3)
        label.textColor = .white
        return label
    }()

    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel.createLabel(withText: "1", font: .customFont(font: .sup, style: .ercharge, size: 20), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1, kern: 3)
        label.textColor = .white
        label.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 2
        label.layer.shadowOffset = CGSize(width: 2, height: 5)
        return label
    }()

    private (set) var imgPoints: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlanePoints
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.642, blue: 0.311, alpha: 0.8).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 9
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private(set) lazy var leaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setUpConstraints()
    }
    
        func setupUI() {
            backgroundColor = .clear
            contentView.addSubview(leaderView)
            contentView.backgroundColor = .clear
            selectionStyle = .none
            [userImage, imgPoints, nameLabel, scoreLabel, numberLabel] .forEach(leaderView.addSubview(_:))
            numberLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
            nameLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
            scoreLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        scoreLabel.text =  nil
    }
    
    private func setUpConstraints(){
        
        leaderView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(46.autoSize)
            make.width.equalTo(354.autoSize)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        userImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(numberLabel.snp.right).offset(12)
            make.size.equalTo(40.autoSize)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImage)
            make.left.equalTo(userImage.snp.right).offset(8)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        imgPoints.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreLabel)
            make.right.equalTo(scoreLabel.snp.left).offset(-8)
            make.size.equalTo(25)
        }
    }
}
