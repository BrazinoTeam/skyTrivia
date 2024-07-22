//
//  InfoQuizView.swift
import Foundation
import UIKit
import SnapKit

class InfoQuizView: UIView {
    
    private (set) var imgPlanes: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.5
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private (set) var backBtn: UIButton = {
        let button = UIButton()
        button.setImage(.btnBack, for: .normal)
        return button
    }()
    
    private (set) var imgContainerQuiz: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgContQuiz
        return imageView
    }()
    
    private (set) var imgAirPlanes: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgPlanePoints
        imageView.layer.shadowColor = UIColor(red: 1, green: 0.642, blue: 0.311, alpha: 0.3).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 27
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return imageView
    }()
    
    private var circleViews: [UIView] = []
    private var isInitialGradientApplied = false

    private let circleContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        return stackView
    }()
    
    private (set) var quizLabel: UILabel = {
        let label = UILabel.createLabel(withText: "What role did the Lockheed Vega primarily play in aviation history besides record-breaking flights ?", font: .customFont(font: .sup, style: .ercharge, size: 12), textColor: .white, paragraphSpacing: 1, lineHeightMultiple: 1.09, kern: 1.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private (set) var imgChoose: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgChooseLabel
        return imageView
    }()
    
    private(set) var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = .clear
          collectionView.register(QuizOptionCell.self, forCellWithReuseIdentifier: "QuizOptionCell")
          return collectionView
      }()
    
    private (set) var quizBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(.btnAnswer, for: .normal)
        btn.setBackgroundImage(.btnAnswerSelect, for: .highlighted)
        return btn
    }()
    
    private var backgroundGradientLayer: CAGradientLayer?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        (1...10).forEach { _ in
            let circleView = UIView()
            circleView.backgroundColor = .gray
            circleView.layer.cornerRadius = 6.autoSize
            circleView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            circleView.layer.shadowOpacity = 1
            circleView.layer.shadowRadius = 2
            circleView.layer.shadowOffset = CGSize(width: 2, height: 5)
            circleView.snp.makeConstraints { make in
                make.width.height.equalTo(12.autoSize)
            }
            circleViews.append(circleView)
            circleContainerView.addArrangedSubview(circleView)
        }
        
        [imgPlanes, backBtn, imgContainerQuiz, imgAirPlanes, circleContainerView, quizLabel, imgChoose, collectionView, quizBtn] .forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
     
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(56.autoSize)
        }
        
        imgPlanes.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.top).offset(-98)
            make.left.right.equalToSuperview().inset(-62)
            make.height.equalTo(515)
            make.width.equalTo(519)
        }
        
        imgContainerQuiz.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(220)
        }
        
        imgAirPlanes.snp.makeConstraints { make in
            make.centerX.equalTo(imgContainerQuiz)
            make.centerY.equalTo(imgContainerQuiz.snp.top)
            make.height.equalTo(98)
            make.width.equalTo(89)
        }
        
        circleContainerView.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
        }
        
        quizLabel.snp.makeConstraints { make in
            make.top.equalTo(imgContainerQuiz.snp.top).offset(48.autoSize)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(72.autoSize)
        }
        
        imgChoose.snp.makeConstraints { make in
            make.top.equalTo(quizLabel.snp.bottom).offset(12.autoSize)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imgChoose.snp.bottom).offset(20.autoSize)
            make.left.right.equalToSuperview().inset(20.autoSize)
            make.height.equalTo(216)
        }
        
        quizBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24.autoSize)
            make.centerX.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyInitialGradient()
    }

    private func applyInitialGradient() {
        if !isInitialGradientApplied, let firstCircleView = circleViews.first {
            firstCircleView.layoutIfNeeded() // Убедимся, что размеры установлены
            applyBackgroundGradient(to: firstCircleView, colors: [UIColor.cBiegeGradOne.cgColor, UIColor.cBiegeGradTwo.cgColor])
            isInitialGradientApplied = true // Обновляем флаг
        }
    }
    
    func updateCircleColor(at index: Int, isCorrect: Bool, isCurrent: Bool) {
        guard index < circleViews.count else { return }
        
        let circleView = circleViews[index]
        
        if isCurrent {
            applyBackgroundGradient(to: circleView, colors: [UIColor.cBiegeGradOne.cgColor, UIColor.cBiegeGradTwo.cgColor])
        } else {
            removeBackgroundGradient(from: circleView)
            circleView.backgroundColor = isCorrect ? .сGradGreenOne : .red
        }
    }

    private func applyBackgroundGradient(to view: UIView, colors: [CGColor]) {
        removeBackgroundGradient(from: view) // Убедитесь, что предыдущий градиент удален
        
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.colors = colors
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundGradientLayer.frame = view.bounds
        backgroundGradientLayer.cornerRadius = view.layer.cornerRadius
        
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
    }
    
    private func removeBackgroundGradient(from view: UIView) {
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        view.backgroundColor = .clear
    }
    
    private func applyBackgroundGradient() {
        removeBackgroundGradient()
        
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.colors = [UIColor.cBiegeGradOne.cgColor, UIColor.cBiegeGradTwo.cgColor]
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        backgroundGradientLayer.frame = bounds
        backgroundGradientLayer.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(backgroundGradientLayer, at: 0)
        self.backgroundGradientLayer = backgroundGradientLayer
    }
    
    private func removeBackgroundGradient() {
        backgroundGradientLayer?.removeFromSuperlayer()
        backgroundGradientLayer = nil
        backgroundColor = .clear
    }
}
