//
//  HomeView.swift

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    
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
        label.text = "Welcome"
        let attrString = CustomTextStyle.labelAttrString.attributedString(with: "Welcome")
        label.attributedText = attrString

        label.font = .customFont(font: .sup, style: .ercharge, size: 36)
        label.textAlignment = .center
        label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let btnRead: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.btnRead, for: .normal)
        button.setBackgroundImage(.btnReadTapped, for: .highlighted)
        return button
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

        [bgImage, imgContPoints, titleLabel, collectionView, btnRead] .forEach(addSubview(_:))
        imgContPoints.addSubview(imgPlane)
        imgContPoints.addSubview(pointLabel)
    }
    
    private func setupConstraints() {
     
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
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imgContPoints.snp.bottom).offset(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(385)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        btnRead.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            let center = offset.x + environment.container.contentSize.width / 2
            items.forEach { item in
                let distance = abs(center - item.center.x)
                let normalizedDistance = min(distance / environment.container.contentSize.width, 1.0)
                let scale = 1 - 0.25 * normalizedDistance
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                item.alpha = 1 - 0.5 * normalizedDistance
            }
        }

        return UICollectionViewCompositionalLayout(section: section)
    }

}

