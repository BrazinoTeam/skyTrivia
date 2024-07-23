import Foundation
import UIKit

class HomeVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    private let titleLabelCell: [String] = ["Lockheed Vega", "Beechcraft Model 18", "Piper PA-23 Apache", "Cessna 310", "Beechcraft Baron", "Cessna 402", "Beechcraft King Air"]
    private let imageCell: [UIImage] = [.imgLockheedVega, .imgBeechcraftModel18, .imgPiperPA, .imgCessna310, .imgBeechcraftBaron, .imgCessna402, .imgBeechcraftKingAir]
    private let numberOfItemsMultiplier = 100

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
        scrollToMiddle()
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
        let vc = InfoHomeVC()
        vc.selectCount = selectedIndexPath.item % titleLabelCell.count
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func scrollToMiddle() {
        let middleIndexPath = IndexPath(item: (titleLabelCell.count * numberOfItemsMultiplier) / 2, section: 0)
        contentView.collectionView.scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: false)
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleLabelCell.count * numberOfItemsMultiplier
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseId, for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        let index = indexPath.item % titleLabelCell.count
        cell.titleLabel.text = titleLabelCell[index]
        cell.imageAirplanes.image = imageCell[index]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        updateSelectedIndexPath(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        updateSelectedIndexPath(collectionView)
    }
    
    private func updateSelectedIndexPath(_ collectionView: UICollectionView) {
        let centerPoint = CGPoint(x: collectionView.bounds.midX + collectionView.contentOffset.x, y: collectionView.bounds.midY + collectionView.contentOffset.y)
        if let visibleIndexPath = collectionView.indexPathForItem(at: centerPoint) {
            selectedIndexPath = visibleIndexPath
        }
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            updateSelectedIndexPath(collectionView)
            
            let itemsCount = titleLabelCell.count * numberOfItemsMultiplier
            let middleIndexPath = IndexPath(item: itemsCount / 2, section: 0)
            
            let currentOffset = collectionView.contentOffset.x
            let contentWidth = collectionView.contentSize.width
            let width = collectionView.frame.width
            
            if currentOffset <= 0 {
                collectionView.scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: false)
            } else if currentOffset + width >= contentWidth {
                collectionView.scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
}
