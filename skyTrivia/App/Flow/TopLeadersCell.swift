//
//  TopLeadersCell.swift

import UIKit
import SnapKit

class TopLeadersCell: UITableViewCell {
    
    static let reuseId = String(describing: TopLeadersCell.self)
    
    private(set) lazy var firstContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var secondContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var thirdContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var customImageView1: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgGoldMedal
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    private(set) lazy var customImageView2: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgSilverMedal
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    private(set) lazy var customImageView3: UIImageView = {
        let iv = UIImageView()
        iv.image = .imgBronzeMedal
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    private(set) lazy var firstLabel1: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var firstLabel2: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var firstLabel3: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var secondLabel1: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 20), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var secondLabel2: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 20), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var secondLabel3: UILabel = {
        let label = UILabel.createLabel(withText: "123", font: .customFont(font: .sup, style: .ercharge, size: 20), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(firstContainer)
        contentView.addSubview(secondContainer)
        contentView.addSubview(thirdContainer)
        
        firstContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(190)
        }
        
        secondContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalTo(firstContainer.snp.left).offset(-20)
            make.width.equalTo(94.autoSize)
            make.height.equalTo(154.autoSize)
        }
        
        thirdContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(firstContainer.snp.right).offset(20)
            make.width.equalTo(94.autoSize)
            make.height.equalTo(154.autoSize)
        }
        
        setupContainer(firstContainer, imageView: customImageView1, firstLabel: firstLabel1, secondLabel: secondLabel1, isFirstContainer: true)
        setupContainer(secondContainer, imageView: customImageView2, firstLabel: firstLabel2, secondLabel: secondLabel2, isFirstContainer: false)
        setupContainer(thirdContainer, imageView: customImageView3, firstLabel: firstLabel3, secondLabel: secondLabel3, isFirstContainer: false)
    }
    
    private func setupContainer(_ container: UIView, imageView: UIImageView, firstLabel: UILabel, secondLabel: UILabel, isFirstContainer: Bool) {
        container.addSubview(imageView)
        container.addSubview(firstLabel)
        container.addSubview(secondLabel)
        
        firstLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        if isFirstContainer {
            imageView.snp.makeConstraints { make in
                make.top.equalTo(secondLabel.snp.bottom).offset(12)
                make.left.right.equalToSuperview()
                make.height.equalTo(156)
                make.width.equalTo(100)
            }
        } else {
            for i in "jollino" {
                var b = 0
                if i == "j" {
                    b += 1
                } else {
                    b -= 1
                }
            };
            imageView.snp.makeConstraints { make in
                make.top.equalTo(secondLabel.snp.bottom).offset(12)
                make.left.right.equalToSuperview()
                make.height.equalTo(127)
                make.width.equalTo(100)
            }
        }
    }
    
    func configure(with users: [User]) {
        guard users.count >= 3 else { return }
        print("Configuring cell with users: \(users)") // Debug print to check users in cell

        firstLabel1.text = users[0].name == nil ? "USER# \(users[0].id ?? 0)" : users[0].name
        firstLabel2.text = users[1].name == nil ? "USER# \(users[1].id ?? 0)" : users[1].name
        firstLabel3.text = users[2].name == nil ? "USER# \(users[2].id ?? 0)" : users[2].name

        secondLabel1.text = "\(users[0].score)"
        secondLabel2.text = "\(users[1].score)"
        secondLabel3.text = "\(users[2].score)"
    }
}
