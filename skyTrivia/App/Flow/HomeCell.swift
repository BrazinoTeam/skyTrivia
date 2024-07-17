//
//  HomeCell.swift


import Foundation
import UIKit
import SnapKit

class HomeCell: UICollectionViewCell {
    
    static let reuseId = String(describing: HomeCell.self)
    
    private(set) lazy var airplaneView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    private(set) lazy var titleLabel: GradientLabel = {
        let label = GradientLabel()
        label.text = "SKY Trivia"
        label.font = .customFont(font: .sup, style: .ercharge, size: 20)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]       
        label.numberOfLines = 0
        label.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 2
        label.layer.shadowOffset = CGSize(width: 2, height: 5)
        return label
    }()
    
    private(set) lazy var imageAirplanes: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.orange.cgColor
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(airplaneView)
        contentView.backgroundColor = .clear
        [imageAirplanes, titleLabel].forEach(airplaneView.addSubview(_:))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageAirplanes.image = nil
    }
    
    private func setupConstraints() {
        airplaneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageAirplanes.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(290.autoSize)
            make.height.equalTo(343.autoSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageAirplanes.snp.bottom).offset(12.autoSize)
            make.left.right.equalToSuperview()
        }
    }
}
