//
//  HomeVC.swift

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    
    private var contentView: HomeView {
        view as? HomeView ?? HomeView()
    }
    
    override func loadView() {
        view = HomeView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
