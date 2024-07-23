import Foundation
import UIKit
import SnapKit

class LoadingVC: UIViewController {
    
    private var auth = TokenService.shared

    var contentView: LoadingView {
        view as? LoadingView ?? LoadingView()
    }
    
    private var segments: [UIView] = []

    override func loadView() {
        view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingBar()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadTabBar()
        }
        animateLoadingBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func createLoadingBar() {
        let segmentWidth: CGFloat = 7.17
        let segmentHeight: CGFloat = 18
        let spacing: CGFloat = 3
        let numberOfSegments = 35
        
        for row in 0..<1 {
            for i in 0..<numberOfSegments {
                let segment = UIView()
                segment.layer.cornerRadius = 2
                segment.clipsToBounds = true
                segment.backgroundColor = .red
                segment.alpha = 0.5
                segment.frame = CGRect(
                    x: CGFloat(i) * (segmentWidth + spacing),
                    y: CGFloat(row) * (segmentHeight + spacing),
                    width: segmentWidth,
                    height: segmentHeight
                )
                addGradientLayer(to: segment)
                segments.append(segment)
                contentView.loadView.addSubview(segment)
            }
        }
    }
    
    private func addGradientLayer(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.cGradOne.cgColor, UIColor.cGradTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func animateLoadingBar() {
        let totalDuration: TimeInterval = 2.5
        let durationPerSegment = totalDuration / Double(segments.count)
        
        for (index, segment) in segments.enumerated() {
            UIView.animate(withDuration: durationPerSegment, delay: durationPerSegment * Double(index), options: [], animations: {
                segment.alpha = 1.0
            }, completion: { _ in
                self.animateGradient(segment: segment)
            })
        }
    }
    
    private func animateGradient(segment: UIView) {
        guard let gradientLayer = segment.layer.sublayers?.first as? CAGradientLayer else { return }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = [UIColor.cGradOne.cgColor, UIColor.cGradTwo.cgColor]
        colorAnimation.toValue = [UIColor.cGradTwo.cgColor, UIColor.cGradOne.cgColor]
        colorAnimation.duration = 1.5
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = .infinity
        
        gradientLayer.add(colorAnimation, forKey: "colorChange")
    }
    
    func loadTabBar() {
      
            Task {
                do {
                    try await auth.authenticate()
                    checkToken()
                    createUser()
                    let vc = NavigationTabBar()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    
    private func createUser() {
        if MemoryApp.shared.userID == nil {
            let payload = CreateReqPay(name: nil, score: MemoryApp.shared.scorePoints)
            PostRequestService.shared.createUser(payload: payload) { [weak self] createResponse in
                guard let self = self else { return }
                MemoryApp.shared.userID = createResponse.id
            } errorCompletion: { error in
                print("Ошибка получени данных с бека")
            }
        }
    }

    private func checkToken() {
        guard let token = auth.token else {
            return
        }
    }
}

extension UIColor {
    static var cGradOne: UIColor {
        return UIColor.cGradRedOne
    }
    static var cGradTwo: UIColor {
        return UIColor.cGradRedTwo
    }
}
