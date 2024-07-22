//
//  HomeVC.swift
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    private let titleLabelCell: [String] = ["Lockheed Vega", "Beechcraft Model 18", "Piper PA-23 Apache", "Cessna 310", "Beechcraft Baron", "Cessna 402", "Beechcraft King Air"]
    private let imageCell: [UIImage] = [.imgLockheedVega, .imgBeechcraftModel18, .imgPiperPA, .imgCessna310, .imgBeechcraftBaron, .imgCessna402, .imgBeechcraftKingAir]

    private var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        tappedButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePointsLabel()
    }
    
    private func updatePointsLabel() {
        contentView.pointLabel.text = "\(MemoryApp.shared.scorePoints)"
        contentView.pointLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
    }
    
    private func configureCollection() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseId)
    }
    
    private func tappedButtons() {
        contentView.btnRead.addTarget(self, action: #selector(tappedRead), for: .touchUpInside)
    }
    
    @objc private func tappedRead() {
        guard let selectedIndexPath = selectedIndexPath else {
            print("No visible cell index found")
            return
        }
        print("READ at index \(selectedIndexPath.item)")
        let vc = InfoHomeVC()
        vc.selectCount = selectedIndexPath.item
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleLabelCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = titleLabelCell[indexPath.item]
        cell.imageAirplanes.image = imageCell[indexPath.item]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Если ячейка центрируется, устанавливаем ее как выбранную
        updateSelectedIndexPath(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Если ячейка центрируется, устанавливаем ее как выбранную
        updateSelectedIndexPath(collectionView)
    }
    
    private func updateSelectedIndexPath(_ collectionView: UICollectionView) {
        let centerPoint = CGPoint(x: collectionView.bounds.midX + collectionView.contentOffset.x, y: collectionView.bounds.midY + collectionView.contentOffset.y)
        if let visibleIndexPath = collectionView.indexPathForItem(at: centerPoint) {
            selectedIndexPath = visibleIndexPath
        }
    }
}
