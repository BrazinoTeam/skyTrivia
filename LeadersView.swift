//
//  LeadersView.swift

import Foundation
import UIKit
import SnapKit

class LeadersView: UIView {
    
    
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
    
    private (set) var imgTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgTitleLeaders
        return imageView
    }()
    
    private(set) lazy var leadersTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        tableView.register(LeaderCell.self, forCellReuseIdentifier: LeaderCell.reuseId)
        tableView.register(TopLeadersCell.self, forCellReuseIdentifier: TopLeadersCell.reuseId)
        tableView.separatorStyle = .none
        return tableView
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

        [bgImage, imgContPoints, imgTitle, leadersTable] .forEach(addSubview(_:))
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
        
        imgTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgContPoints.snp.bottom).offset(40)
        }
        
        leadersTable.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imgTitle.snp.bottom).offset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-56)
        }
    }
}

