import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    private(set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLogo
        imageView.contentMode = .scaleToFill
        return imageView
    }()
   
    private(set) var loadView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.cRed.withAlphaComponent(0.8).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 25
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    private(set) var loadLabel: GradientLabel = {
        let label = GradientLabel()
           label.text = "loading"
           label.font = UIFont.customFont(font: .sup, style: .ercharge, size: 20)
           label.textAlignment = .center
           label.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
        return label
    }()
    
    private var segments: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [bgImage, loadView, loadLabel].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(353)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-150)
        }
        
        loadLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(loadView.snp.bottom).offset(16)
        }
    }
  
}
