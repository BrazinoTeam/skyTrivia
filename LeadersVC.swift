
import Foundation
import UIKit

class LeadersVC: UIViewController {
    
    var users = [User]()

    private var contentView: LeadersView {
        view as? LeadersView ?? LeadersView()
    }
    
    override func loadView() {
        view = LeadersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
        updatePointsLabel()
    }
    
    
    private func updatePointsLabel() {
        contentView.pointLabel.text = "\(MemoryApp.shared.scorePoints)"
        contentView.pointLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
    }
    
    private func configureTableView() {
        contentView.leadersTable.dataSource = self
        contentView.leadersTable.delegate = self
        contentView.leadersTable.separatorStyle = .none
    }
    
    private func sortPointsUsers() {
        users.sort { $1.score < $0.score }
    }
    
    private func loadUsers() {
        GetRequestService.shared.getLeadeboards { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.sortPointsUsers()
            self.updateContentView()
            self.contentView.topLeadView.isHidden = false
        } errorCompletion: { error in
            print("Error loading users: \(error)")
        }
    }
    
    private func updateContentView() {
        let topThreeUsers = Array(users.prefix(3))
        let remainingUsers = Array(users.dropFirst(3))
        
        contentView.topLeadView.configure(with: topThreeUsers)
        contentView.leadersTable.reloadData()
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        contentView.leadersTable.layoutIfNeeded()
        let height = contentView.leadersTable.contentSize.height
        contentView.updateTableViewHeight(height: height)
    }
}

extension LeadersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count > 3 ? users.count - 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderCell.reuseId, for: indexPath)
        
        guard let leaderCell = cell as? LeaderCell else {
            return cell
        }
        
        let index = indexPath.row + 3
        let number = index + 1
        let user = users[index]
        
        setupCell(leaderCell: leaderCell, number: number, user: user)
        
        return leaderCell
    }
    private func setupCell(leaderCell: LeaderCell, number: Int, user: User) {
        let borderView = leaderCell.leaderView.viewWithTag(101) as? UIView ?? UIView()
        borderView.tag = 101

        if user.id == MemoryApp.shared.userID {
            borderView.removeFromSuperview()

            // Create gradient border
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.cBiegeGradOne.cgColor, UIColor.cBiegeGradTwo.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.frame = leaderCell.leaderView.bounds

            // Create shape layer as mask with rounded corners
            let shapeLayer = CAShapeLayer()
            shapeLayer.lineWidth = 4
            let path = UIBezierPath(roundedRect: leaderCell.leaderView.bounds, cornerRadius: 6).cgPath
            shapeLayer.path = path
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.black.cgColor
            gradientLayer.mask = shapeLayer

            // Remove existing gradient layers to avoid duplicates
            leaderCell.leaderView.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

            leaderCell.leaderView.layer.addSublayer(gradientLayer)
            
            // Apply corner radius to the view itself
            leaderCell.leaderView.layer.cornerRadius = 6
            leaderCell.leaderView.layer.masksToBounds = true
        } else {
            if borderView.superview == nil {
                leaderCell.leaderView.addSubview(borderView)
                borderView.snp.remakeConstraints { make in
                    make.height.equalTo(2)
                    make.bottom.equalTo(leaderCell.leaderView)
                    make.left.right.equalTo(leaderCell.leaderView).inset(10)
                }
            }
            leaderCell.leaderView.layer.borderWidth = 0
            leaderCell.leaderView.layer.borderColor = UIColor.clear.cgColor
            leaderCell.leaderView.layer.cornerRadius = 0

            // Remove existing gradient layers to avoid duplicates
            leaderCell.leaderView.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        }

        leaderCell.numberLabel.text = "\(number)"
        leaderCell.scoreLabel.text = "\(user.score)"
        leaderCell.nameLabel.text = user.name == nil || user.name == "" ? "USER# \(user.id ?? 0)" : user.name
        leaderCell.numberLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
        leaderCell.nameLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
        leaderCell.scoreLabel.setGradientText(colors: [UIColor.cBiegeGradOne, UIColor.cBiegeGradTwo])
    }


}
