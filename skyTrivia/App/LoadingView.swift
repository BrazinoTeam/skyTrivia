//
//  LoadingView.swift

import Foundation
import UIKit
import SnapKit

class LoadingView: UIView {
    
    private (set) var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bgLogo
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
   
    private (set) var loadView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
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

        [bgImage, loadView] .forEach(addSubview(_:))

    }
    
    private func setupConstraints() {
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(11)
            make.width.equalTo(337)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-150)
        }
        
     
    }
}
