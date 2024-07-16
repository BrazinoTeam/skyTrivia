//
//  NavigationTabBar.swift

import UIKit

final class NavigationTabBar: UITabBarController {
 
    private let home = HomeVC()
    private let profile = ProfileVC()
    private let bonus = BonusVC()
    private let leaders = LeadersVC()
    private let info = InfoVC()
    
    private lazy var btn1 = getButton(icon: "btnHome", selectedIcon: "btnHomeSelect", tag: 0, action: action)
    private lazy var btn2 = getButton(icon: "btnProfile", selectedIcon: "btnProfileSelect", tag: 1, action: action)
    private lazy var btn3 = getButton(icon: "btnBonus", selectedIcon: "btnBonusSelect", tag: 2, action: action)
    private lazy var btn4 = getButton(icon: "btnLead", selectedIcon: "btnLeadSelect", tag: 3, action: action)
    private lazy var btn5 = getButton(icon: "btnInfo", selectedIcon: "btnInfoSelect", tag: 4, action: action)

    lazy var action = UIAction { [weak self] sender in
        guard
            let sender = sender.sender as? UIButton,
            let self = self
        else { return }
        
        self.updateSelectedButton(sender.tag)
        self.selectedIndex = sender.tag
    }

    private lazy var customBar: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .green
        stackView.frame = CGRect(x: 0, y: view.frame.height - 90, width: view.frame.width, height: 90)
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        stackView.addArrangedSubview(btn3)
        stackView.addArrangedSubview(btn4)
        stackView.addArrangedSubview(btn5)
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .black

        profile.title = "Profile"
        leaders.title = "Leaders"
        home.title = "Home"
        bonus.title = "Bonus"
        info.title = "Info"
        view.addSubview(customBar)
        tabBar.isHidden = true
        setViewControllers([home, profile, bonus, leaders, info], animated: true)
        selectedViewController = home
        updateSelectedButton(0)
        addGradientLayer(to: customBar)
    }
    
    private func addGradientLayer(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.cTabOne.cgColor, UIColor.cTabTwo.cgColor, UIColor.cTabThree.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func getButton(icon: String, selectedIcon: String, tag: Int, action: UIAction) -> UIButton {
        return {
            let image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
            $0.setImage(image, for: .normal)
            $0.tag = tag
            $0.accessibilityIdentifier = icon
            $0.accessibilityHint = selectedIcon
            return $0
        }(UIButton(primaryAction: action))
    }
    
    private func updateSelectedButton(_ selectedIndex: Int) {
        let buttons = [btn1, btn2, btn3, btn4, btn5]
        
        for (index, button) in buttons.enumerated() {
            let icon = button.accessibilityIdentifier ?? ""
            let selectedIcon = button.accessibilityHint ?? ""
            
            if icon.isEmpty || selectedIcon.isEmpty {
                print("Icon or selectedIcon is empty for button at index \(index)")
                continue
            }
            
            if index == selectedIndex {
                let selectedImage = UIImage(named: selectedIcon)?.withRenderingMode(.alwaysOriginal)
                button.setImage(selectedImage, for: .normal)
                
            } else {
                let image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
                button.setImage(image, for: .normal)
            }
        }
    }
    
    func selectTab(at index: Int) {
        guard let button = customBar.arrangedSubviews.first(where: { ($0 as? UIButton)?.tag == index }) as? UIButton else { return }
        button.sendActions(for: .touchUpInside)
    }
}

