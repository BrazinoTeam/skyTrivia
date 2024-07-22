//
//  BonusVC.swift

import Foundation
import UIKit
import SnapKit

class BonusVC: UIViewController {
    
    private var fullScreenView: UIView?
    private let uD = MemoryApp.shared
    private var isTime: Bool = true
    
    private var arrayPoints: [Int] = [100, 1000, 2000, 5000]
    private var contentView: BonusView {
        view as? BonusView ?? BonusView()
    }
    
    override func loadView() {
        view = BonusView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelScore()
        goDailyScreen()

    }
    private func updateLabelScore() {
        contentView.pointLabel.text = "\(uD.scorePoints)"
        contentView.timerPointLabel.text = "\(uD.scorePoints)"
        
    }
    
    private func selectBtn() {
        contentView.setButtonTargets(target: self, action: #selector(buttonTapped(_:)))
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
    
    @objc private func buttonTapped(_ sender: UIButton) {
        print("sender - \(sender.tag)")
        let randomBonus = arrayPoints.randomElement() ?? 0
        uD.scorePoints += randomBonus
        updateScore()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.presentModalView(points: randomBonus)
        }
    }
    
    private func presentModalView(points: Int) {
        if fullScreenView == nil {
            fullScreenView = UIView(frame: self.view.bounds)
            fullScreenView!.alpha = 0
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor.cTabOne.withAlphaComponent(0.75).cgColor,
                UIColor.cTabTwo.withAlphaComponent(0.75).cgColor,
                UIColor.cTabThree.withAlphaComponent(0.75).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.frame = fullScreenView!.bounds
            fullScreenView!.layer.insertSublayer(gradientLayer, at: 0)
            let viewConteiner = UIView()
            
            fullScreenView!.addSubview(viewConteiner)
            
            let imageBonusView = UIImageView(image: .imgContainerBonus)
            imageBonusView.contentMode = .scaleAspectFit
            imageBonusView.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
            imageBonusView.layer.shadowOpacity = 1
            imageBonusView.layer.shadowRadius = 35
            imageBonusView.layer.shadowOffset = CGSize(width: 0, height: 2)
            viewConteiner.addSubview(imageBonusView)
            
            let titleLabel = GradientLabel()
            titleLabel.text = "Congratulations!"
            titleLabel.font = .customFont(font: .sup, style: .ercharge, size: 20)
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
            viewConteiner.addSubview(titleLabel)
            
            let subtitleLabelView = GradientLabel()
            subtitleLabelView.text = "You Win"
            subtitleLabelView.font = .customFont(font: .sup, style: .ercharge, size: 20)
            subtitleLabelView.numberOfLines = 0
            subtitleLabelView.textAlignment = .center
            subtitleLabelView.gradientColors = [.cOrange, .cOrangeTwo, .cOrange]
            viewConteiner.addSubview(subtitleLabelView)
            
            let pointContainer = UIImageView(image: .imgBonusPointsCont)
            pointContainer.contentMode = .scaleAspectFit
            viewConteiner.addSubview(pointContainer)
            
            let imgPlanes = UIImageView(image: .imgPlanePoints)
            imgPlanes.contentMode = .scaleAspectFit
            pointContainer.addSubview(imgPlanes)
            
            let pointLabel = GradientLabel()
            pointLabel.text = "+ \(points)".uppercased()
            pointLabel.font = .customFont(font: .sup, style: .ercharge, size: 20)
            pointLabel.numberOfLines = 0
            pointLabel.textAlignment = .center
            pointLabel.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
            pointContainer.addSubview(pointLabel)
            
            let imgCases = UIImageView(image: .imgCases)
            imgCases.contentMode = .scaleAspectFit
            viewConteiner.addSubview(imgCases)
            
            let thanksBtn = UIButton()
            thanksBtn.setBackgroundImage(.thanksBtn, for: .normal)
            thanksBtn.setBackgroundImage(.thanksSelectBtn, for: .highlighted)
            thanksBtn.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
            fullScreenView!.addSubview(thanksBtn)
            
            viewConteiner.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(512)
                make.width.equalTo(330)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(30)
                make.top.equalToSuperview().offset(32)
            }
            
            subtitleLabelView.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(30)
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
            }
            
            pointContainer.snp.makeConstraints { make in
                make.centerX.equalTo(imageBonusView)
                make.top.equalTo(subtitleLabelView.snp.bottom).offset(20)
                make.height.equalTo(60)
                make.width.equalTo(160)
            }
            
            imgPlanes.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12)
                make.centerY.equalToSuperview()
            }
            
            pointLabel.snp.makeConstraints { make in
                make.left.equalTo(imgPlanes.snp.right).offset(4)
                make.right.equalToSuperview().offset(-12)
                make.centerY.equalTo(imgPlanes)
            }
            
            imgCases.snp.makeConstraints { make in
                make.centerX.equalTo(pointContainer)
                make.top.equalTo(pointContainer.snp.bottom).offset(24)
            }
            
            thanksBtn.snp.makeConstraints { make in
                make.top.equalTo(imgCases.snp.bottom).offset(-36)
                make.centerX.equalToSuperview()
                make.width.equalTo(264)
            }
            
            self.view.addSubview(fullScreenView!)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView!.alpha = 1
        })
    }
    
    @objc func tappedCloseBuy() {
        uD.lastBonusDate = Date()
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView?.alpha = 0
        }) { _ in
            self.fullScreenView?.removeFromSuperview()
            self.fullScreenView = nil
            self.goDailyScreen()
            self.updateLabelScore()
        }
    }
}

extension BonusVC {
    
    func goDailyScreen() {
        if let lastVisitDate = uD.lastBonusDate {
            let calendar = Calendar.current
            if let hours = calendar.dateComponents([.hour], from: lastVisitDate, to: Date()).hour, hours < 24 {
                isTime = true
                contentView.timerView.isHidden = false
                startCountdownTimer()
            } else {
                isTime = false
                contentView.timerView.isHidden = true
            }
        }
    }
    
    private func createAttributedString(text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 0
        paragraphStyle.lineHeightMultiple = 1.03
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .sup, style: .ercharge, size: 50),
            .foregroundColor: UIColor.clear,
            .paragraphStyle: paragraphStyle
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func startCountdownTimer() {
        let calendar = Calendar.current
        
        guard let lastVisitDate = uD.lastBonusDate,
              let targetDate = calendar.date(byAdding: .day, value: 1, to: lastVisitDate) else {
            return
        }
        
        let now = Date()
        if now < targetDate {
            let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                let now = Date()
                if now >= targetDate {
                    UserDefaults.standard.set(now, forKey: "LastVisitDate")
                    self.dismiss(animated: true, completion: nil)
                    timer.invalidate()
                } else {
                    let timeRemaining = calendar.dateComponents([.hour, .minute, .second], from: now, to: targetDate)
                    let timeString = String(format: "%02d:%02d:%02d", timeRemaining.hour ?? 0, timeRemaining.minute ?? 0, timeRemaining.second ?? 0)
                    self.contentView.timerCountTimeLabel.attributedText = self.createAttributedString(text: timeString)
                }
            }
        } else {
            UserDefaults.standard.set(now, forKey: "LastVisitDate")
        }
    }
    
}
