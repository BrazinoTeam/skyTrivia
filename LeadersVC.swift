//
//  LeadersVC.swift

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
        contentView.pointLabel.text = "\(MemoryApp.shared.scorePoints)"

    }
    
    private func configureTableView() {
        contentView.leadersTable.dataSource = self
        contentView.leadersTable.delegate = self
        contentView.leadersTable.separatorStyle = .none
    }
    
    func sortPointsUsers() {
        users.sort {
            $1.score < $0.score
        }
    }
    
    func loadUsers() {
        GetRequestService.shared.getLeadeboards { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.contentView.leadersTable.reloadData()
            self.sortPointsUsers()
        } errorCompletion: { [weak self] error in
            guard self != nil else { return }
            }
        }
}


extension LeadersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count > 3 ? users.count - 3 + 1 : users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopLeadersCell.reuseId, for: indexPath) as? TopLeadersCell else {
                return UITableViewCell()
            }
            let topUsers = Array(users.prefix(3))
            cell.configure(with: topUsers)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeaderCell.reuseId, for: indexPath) as? LeaderCell else {
                return UITableViewCell()
            }
            let user = users[indexPath.row + 2] // Shift the index by 2 to skip top 3 users
            setupCell(leaderCell: cell, number: indexPath.row + 3, user: user)
            return cell
        }
    }
    
    func setupCell(leaderCell: LeaderCell, number: Int, user: User) {
      
        if user.id == MemoryApp.shared.userID {
            leaderCell.leaderView.backgroundColor = UIColor.orange
        } else {
            leaderCell.leaderView.backgroundColor = UIColor.cDarkRed
        }
        leaderCell.numberLabel.text = "\(number)"
        leaderCell.scoreLabel.text = "\(user.score)"
        leaderCell.nameLabel.text = user.name == nil ? "USER# \(user.id ?? 0)" : user.name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 220 : UITableView.automaticDimension
    }
}
