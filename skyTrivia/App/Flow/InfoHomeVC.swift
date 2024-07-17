//
//  InfoHomeVC.swift


import Foundation
import UIKit

class InfoHomeVC: UIViewController {
    
    var selectCount: Int = 0 {
        didSet {
        updateInfo()
        }
    }
    
    
    private var contentView: InfoHomeView {
        view as? InfoHomeView ?? InfoHomeView()
    }
    
    override func loadView() {
        view = InfoHomeView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectBtn()
    }
    
    private func selectBtn() {
        contentView.backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    private let imageCell: [UIImage] = [.imgLockheedVega, .imgBeechcraftModel18, .imgPiperPA, .imgCessna310, .imgBeechcraftBaron, .imgCessna402, .imgBeechcraftKingAir]

    private func updateInfo() {
        switch selectCount {
        case 0:
            contentView.titleLabel.text = "Lockheed Vega"
            contentView.centerImage.image = .imgLockheedVega
        case 1:
            contentView.titleLabel.text = "Beechcraft Model 18"
            contentView.centerImage.image = .imgBeechcraftModel18

        case 2:
            contentView.titleLabel.text = "Piper PA-23 Apache"
            contentView.centerImage.image = .imgPiperPA

        case 3:
            contentView.titleLabel.text = "Cessna 310"
            contentView.centerImage.image = .imgCessna310

        case 4:
            contentView.titleLabel.text = "Beechcraft Baron"
            contentView.centerImage.image = .imgBeechcraftBaron

        case 5:
            contentView.titleLabel.text = "Cessna 402"
            contentView.centerImage.image = .imgCessna402

        case 6:
            contentView.titleLabel.text = "Beechcraft King Air"
            contentView.centerImage.image = .imgBeechcraftKingAir
            
        default:
            break

        }
    }
}
