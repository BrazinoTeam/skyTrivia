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
    
    private (set) var pointLabel: UILabel = {
        let label = UILabel.createLabel(withText: "\(MemoryApp.shared.scorePoints)", font: .customFont(font: .sup, style: .ercharge, size: 20), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1, kern: 3)
        label.textAlignment = .center
        return label
    }()
    
    private (set) var imgTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgTitleLeaders
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
    
    private(set) lazy var topLeadView: TopLeadersView = {
        let view = TopLeadersView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private(set) lazy var leadersTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        tableView.register(LeaderCell.self, forCellReuseIdentifier: LeaderCell.reuseId)
        tableView.separatorStyle = .none
        let backgroundImage = UIImageView(image: .imgBGLeadCell)
        backgroundImage.contentMode = .scaleToFill
        tableView.backgroundView = backgroundImage

        return tableView
    }()
    
    private var tableHeightConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [bgImage, imgContPoints, imgTitle, scrollView] .forEach(addSubview(_:))
        imgContPoints.addSubview(imgPlane)
        imgContPoints.addSubview(pointLabel)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(topLeadView)
        contentView.addSubview(leadersTable)
    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imgContPoints.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(74.autoSize)
        }
        
        imgPlane.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        pointLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imgPlane)
            make.left.equalTo(imgPlane.snp.right).offset(12)
        }
        
        imgTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgContPoints.snp.bottom).offset(40)
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imgTitle.snp.bottom).offset(24)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-56)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        topLeadView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(217)
        }
        
        leadersTable.snp.makeConstraints { make in
            make.top.equalTo(topLeadView.snp.bottom).offset(24)
            make.left.right.bottom.equalToSuperview().inset(-4)
            tableHeightConstraint = make.height.equalTo(0).constraint
        }
    }

    func updateTableViewHeight(height: CGFloat) {
        tableHeightConstraint?.update(offset: height)
    }
}
