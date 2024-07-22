//
//  InfoQuizVC.swift

import Foundation
import UIKit
import SnapKit

class InfoQuizVC: UIViewController {
    
    private var fullScreenWinView: UIView?
    private var fullScreenLoseView: UIView?

    private var contentView: InfoQuizView {
        view as? InfoQuizView ?? InfoQuizView()
    }
    
    private var airplanes: [AirplaneModel.Airplane] = []
    private var currentQuestionIndex = 0
    private var variants: [AirplaneModel.Airplane.Quiz.Question.Variant] = []
    private var selectedIndexPath: IndexPath? {
        didSet {
            updateAnswerButtonState()
        }
    }
    private var isRightCountAnswers = 0
    private var countAnswers = 0
    private var cointsAnswers = 0
    private var selectedAirplaneIndex: Int
    
    init(selectedAirplaneIndex: Int) {
        self.selectedAirplaneIndex = selectedAirplaneIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = InfoQuizView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        tappedButtons()
        loadAirplanes()
        configureInfoImage()
        
    }
    
    private func configureCollection() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(QuizOptionCell.self, forCellWithReuseIdentifier: "QuizOptionCell")
    }
    
    
    private func configureInfoImage() {
        switch selectedAirplaneIndex {
        case 0:
            contentView.imgPlanes.image = .imgLockheedVega
        case 1:
            contentView.imgPlanes.image = .imgBeechcraftModel18

        case 2:
            contentView.imgPlanes.image = .imgPiperPA
            
        case 3:
            contentView.imgPlanes.image = .imgCessna310
            
        case 4:
            contentView.imgPlanes.image = .imgBeechcraftBaron
            
        case 5:
            contentView.imgPlanes.image = .imgCessna402
            
        case 6:
            contentView.imgPlanes.image = .imgBeechcraftKingAir

        default: break
        }
    }
    
    private func tappedButtons() {
        contentView.backBtn.addTarget(self, action: #selector(goButtonTappedBack), for: .touchUpInside)
        contentView.quizBtn.addTarget(self, action: #selector(answerBtnTapped), for: .touchUpInside)
    }
    
    @objc func goButtonTappedBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func answerBtnTapped() {
        guard let selectedIndexPath = selectedIndexPath else { return }
        
        let isCorrect = variants[selectedIndexPath.item].isRight
        if isCorrect {
            isRightCountAnswers += 1
            cointsAnswers += 10
            MemoryApp.shared.scorePoints += 10
        }
        
        if let selectedCell = contentView.collectionView.cellForItem(at: selectedIndexPath) as? QuizOptionCell {
            selectedCell.setCorrect(isCorrect)
        }
        
        for (index, variant) in variants.enumerated() {
            if variant.isRight {
                if let cell = contentView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? QuizOptionCell {
                    cell.setCorrect(true)
                }
            }
        }
        
        contentView.updateCircleColor(at: countAnswers, isCorrect: isCorrect, isCurrent: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.contentView.quizBtn.isEnabled = true
            self.countAnswers += 1
            
            if self.countAnswers >= 10 {
                if self.isRightCountAnswers >= 6 {
                    MemoryApp.shared.scorePoints += 100
                    MemoryApp.shared.passedTheQuiz += 1
                    self.updateScore()
                    self.presentModalView(title: "Congratulations!", subtitle: .imgSubTitleWin)
                } else {
                    MemoryApp.shared.failedQuiz += 1
                    self.presentModalViewLose(title: "Unfortunately,", subtitle: .imgSubTitleLose)
                }
            } else {
                self.currentQuestionIndex += 1
                self.selectedIndexPath = nil
                self.displayQuestion(at: self.currentQuestionIndex)
            }
            
            // Установите текущий индекс как активный
            self.contentView.updateCircleColor(at: self.countAnswers, isCorrect: false, isCurrent: true)
        }
        contentView.quizBtn.isEnabled = false
    }
    
    private func loadAirplanes() {
        airplanes = AirplaneModel.getAirplanetFromFile()
        
        if let url = Bundle.main.url(forResource: "jsonData", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let jsonString = String(data: data, encoding: .utf8) {
        } else {
            print("Failed to load or parse JSON data.")
        }
        
        if airplanes.isEmpty {
            print("No airplanes found in the JSON data.")
        } else {
            print("Airplanes loaded: \(airplanes.count)")
            displayQuestion(at: currentQuestionIndex)
        }
        
        contentView.collectionView.reloadData()
    }
    
    private func displayQuestion(at index: Int) {
        guard !airplanes.isEmpty else {
            return
        }
        
        let questions = airplanes[selectedAirplaneIndex].quiz.questions
        
        guard index < questions.count else {
            return
        }
        
        let question = questions[index]
        
        let paragraphStyleLabel = NSMutableParagraphStyle()
            paragraphStyleLabel.paragraphSpacing = 0
        paragraphStyleLabel.lineHeightMultiple = 1.09
            
            let attributesLabel: [NSAttributedString.Key: Any] = [
                .font: UIFont.customFont(font: .sup, style: .ercharge, size: 12),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyleLabel,
                .kern: 1.8
            ]
            
            let attributedStringLabel = NSAttributedString(string: "\(question.question)", attributes: attributesLabel)
            contentView.quizLabel.attributedText = attributedStringLabel
            contentView.quizLabel.textAlignment = .center
            contentView.quizLabel.adjustsFontSizeToFitWidth = true
        
        variants = question.variants
        contentView.collectionView.reloadData()
        updateAnswerButtonState()
        
        contentView.updateCircleColor(at: countAnswers, isCorrect: false, isCurrent: true)
    }
    
    private func updateAnswerButtonState() {
        if selectedIndexPath != nil {
            contentView.quizBtn.isEnabled = true
            contentView.quizBtn.setBackgroundImage(.btnAnswer, for: .normal)
            contentView.quizBtn.setBackgroundImage(.btnAnswerSelect, for: .highlighted)
            contentView.quizBtn.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
            contentView.quizBtn.layer.shadowOpacity = 1
            contentView.quizBtn.layer.shadowRadius = 35
            contentView.quizBtn.layer.shadowOffset = CGSize(width: 0, height: 2)

        } else {
            contentView.quizBtn.isEnabled = false
            contentView.quizBtn.setBackgroundImage(.btnAnswerLocked, for: .normal)
            contentView.quizBtn.layer.shadowColor = UIColor.darkGray.cgColor
            contentView.quizBtn.layer.shadowOpacity = 1
            contentView.quizBtn.layer.shadowRadius = 35
            contentView.quizBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    
    func updateScore() {
      
       let payload = UpdatePayload(name: nil, score: MemoryApp.shared.scorePoints)
        PostRequestService.shared.updateData(id: MemoryApp.shared.userID!, payload: payload) { result in
           DispatchQueue.main.async {
               switch result {
               case .success(_):
                   print("Success")
               case .failure(let failure):
                   print("Error - \(failure.localizedDescription)")
               }
           }
       }
   }
}

extension InfoQuizVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return variants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizOptionCell", for: indexPath) as! QuizOptionCell
        let variant = variants[indexPath.item]
        cell.configure(with: variant, at: indexPath.item)
        cell.setSelected(indexPath == selectedIndexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath {
            let previousCell = collectionView.cellForItem(at: previousIndexPath) as? QuizOptionCell
            previousCell?.setSelected(false)
        }
        
        selectedIndexPath = indexPath
        let currentCell = collectionView.cellForItem(at: indexPath) as? QuizOptionCell
        currentCell?.setSelected(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? QuizOptionCell {
            cell.setSelected(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) // Adjusting width for spacing
        return CGSize(width: width, height: 40)
    }
}
extension InfoQuizVC {
    
    func presentModalView(title: String, subtitle: UIImage) {
        if fullScreenWinView == nil {
            fullScreenWinView = UIView(frame: self.view.bounds)
            fullScreenWinView!.backgroundColor = .black.withAlphaComponent(0.8)
            fullScreenWinView!.alpha = 0
            
            let viewContainer = UIView()
            viewContainer.backgroundColor = .clear
            viewContainer.layer.shadowColor = UIColor.cOrange.cgColor
            viewContainer.layer.shadowOpacity = 1
            viewContainer.layer.shadowRadius = 35
            viewContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
            fullScreenWinView!.addSubview(viewContainer)
            
            let bgImage = UIImageView(image: .imgWinLoseCont)
            bgImage.contentMode = .scaleToFill
            bgImage.clipsToBounds = true
            viewContainer.addSubview(bgImage)
            
            let titleLabel = GradientLabel()
            titleLabel.text = title
            titleLabel.font = .customFont(font: .sup, style: .ercharge, size: 20)
            titleLabel.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            viewContainer.addSubview(titleLabel)
            
            let subTitleView = UIImageView(image: subtitle)
            subTitleView.contentMode = .scaleAspectFit
            viewContainer.addSubview(subTitleView)
            
            let imgCointWin = UIImageView(image: .imgPointsWin)
            imgCointWin.contentMode = .scaleAspectFit
            viewContainer.addSubview(imgCointWin)
            
            let imageBonusView = UIImageView(image: .imgCases)
            imageBonusView.contentMode = .scaleAspectFit
            viewContainer.addSubview(imageBonusView)
            
            
            let backButton = UIButton()
            backButton.setBackgroundImage(.btnOK, for: .normal)
            backButton.setBackgroundImage(.btnOKSelect, for: .highlighted)
            backButton.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
            backButton.layer.shadowOpacity = 1
            backButton.layer.shadowRadius = 35
            backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            backButton.addTarget(self, action: #selector(tappedCloseWin), for: .touchUpInside)
            fullScreenWinView!.addSubview(backButton)

            viewContainer.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(567.autoSize)
                make.width.equalTo(329.autoSize)
            }

            bgImage.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            titleLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(32)
                make.top.equalToSuperview().offset(32.autoSize)
            }
            
            subTitleView.snp.makeConstraints { make in
                make.centerX.equalTo(viewContainer)
                make.top.equalTo(titleLabel.snp.bottom).offset(8.autoSize)
            }
            
            imgCointWin.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(subTitleView.snp.bottom).offset(20.autoSize)
            }
            
            imageBonusView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imgCointWin.snp.bottom)
            }
            
            backButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageBonusView.snp.bottom)
                make.height.equalTo(86)
                make.width.equalTo(290)
            }
            
            
            self.view.addSubview(fullScreenWinView!)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenWinView!.alpha = 1
        })
    }

    @objc func tappedCloseWin() {
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenWinView?.alpha = 0
        }) { _ in
            self.fullScreenWinView?.removeFromSuperview()
            self.fullScreenWinView = nil
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func presentModalViewLose(title: String, subtitle: UIImage) {
        if fullScreenLoseView == nil {
            fullScreenLoseView = UIView(frame: self.view.bounds)
            fullScreenLoseView!.backgroundColor = .black.withAlphaComponent(0.8)
            fullScreenLoseView!.alpha = 0
            
            let viewContainer = UIView()
            viewContainer.backgroundColor = .clear
            viewContainer.layer.shadowColor = UIColor.cOrange.cgColor
            viewContainer.layer.shadowOpacity = 1
            viewContainer.layer.shadowRadius = 35
            viewContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
            fullScreenLoseView!.addSubview(viewContainer)
            
            let bgImage = UIImageView(image: .imgWinLoseCont)
            bgImage.contentMode = .scaleToFill
            bgImage.clipsToBounds = true
            viewContainer.addSubview(bgImage)
            
            let titleLabel = GradientLabel()
            titleLabel.text = title
            titleLabel.font = .customFont(font: .sup, style: .ercharge, size: 20)
            titleLabel.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            viewContainer.addSubview(titleLabel)
            
            let subTitleView = UIImageView(image: subtitle)
            subTitleView.contentMode = .scaleAspectFit
            viewContainer.addSubview(subTitleView)
      
            let imageBonusView = UIImageView(image: .imgCasesLose)
            imageBonusView.contentMode = .scaleAspectFit
            viewContainer.addSubview(imageBonusView)
            
            let backButton = UIButton()
            backButton.setBackgroundImage(.btnOK, for: .normal)
            backButton.setBackgroundImage(.btnOKSelect, for: .highlighted)
            backButton.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
            backButton.layer.shadowOpacity = 1
            backButton.layer.shadowRadius = 35
            backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            backButton.addTarget(self, action: #selector(tappedCloseLose), for: .touchUpInside)
            fullScreenLoseView!.addSubview(backButton)

            viewContainer.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(510.autoSize)
                make.width.equalTo(329.autoSize)
            }

            bgImage.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            titleLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(32)
                make.top.equalToSuperview().offset(32.autoSize)
            }
            
            subTitleView.snp.makeConstraints { make in
                make.centerX.equalTo(viewContainer)
                make.top.equalTo(titleLabel.snp.bottom).offset(8.autoSize)
            }
            
            imageBonusView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(subTitleView.snp.bottom).offset(20)
            }
            
            backButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageBonusView.snp.bottom)
                make.height.equalTo(86)
                make.width.equalTo(290)
            }
            
            
            self.view.addSubview(fullScreenLoseView!)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenLoseView!.alpha = 1
        })
    }

    @objc func tappedCloseLose() {
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenLoseView?.alpha = 0
        }) { _ in
            self.fullScreenLoseView?.removeFromSuperview()
            self.fullScreenLoseView = nil
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}
