//
//  InfoQuizVC.swift

import Foundation
import UIKit

class InfoQuizVC: UIViewController {
    
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
        
        // Перекрасить выбранную ячейку в зависимости от правильности ответа
        if let selectedCell = contentView.collectionView.cellForItem(at: selectedIndexPath) as? QuizOptionCell {
            selectedCell.setCorrect(isCorrect)
        }
        
        // Найти ячейку с правильным ответом и изменить её цвет фона на зелёный
        for (index, variant) in variants.enumerated() {
            if variant.isRight {
                if let cell = contentView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? QuizOptionCell {
                    cell.setCorrect(true)
                }
            }
        }
        
        // Обновление цвета круга
        contentView.updateCircleColor(at: countAnswers, isCorrect: isCorrect, isCurrent: false)
        
        // Переход к следующему вопросу через 2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.contentView.quizBtn.isEnabled = true
            self.countAnswers += 1
            
            if self.countAnswers >= 10 {
                if self.isRightCountAnswers >= 6 {
//                    self.navigateToQuizWinVC()
                } else {
//                    self.navigateToQuizLoseVC()
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
            contentView.quizBtn.setBackgroundImage(.btnQuiz, for: .normal)
            contentView.quizBtn.setBackgroundImage(.btnQuizSelect, for: .highlighted)
        } else {
            contentView.quizBtn.isEnabled = false
            contentView.quizBtn.setBackgroundImage(.btnQuizLocked, for: .normal)
        }
    }
    
//    private func navigateToQuizWinVC() {
//        let quizWinVC = QuizWinVC()
//        quizWinVC.coints = isRightCountAnswers
//        quizWinVC.quizIndex = selectedAirplaneIndex
//        navigationController?.pushViewController(quizWinVC, animated: true)
//    }
    
//    private func navigateToQuizLoseVC() {
//        let quizLoseVC = QuizLoseVC()
//        navigationController?.pushViewController(quizLoseVC, animated: true)
//    }
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
}
