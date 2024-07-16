//
//  ProfileVC.swift

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

