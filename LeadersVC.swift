//
//  LeadersVC.swift

import Foundation
import UIKit

class LeadersVC: UIViewController {
    
    
    private var contentView: LeadersView {
        view as? LeadersView ?? LeadersView()
    }
    
    override func loadView() {
        view = LeadersView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

