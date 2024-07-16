//
//  BonusVC.swift

import Foundation
import UIKit

class BonusVC: UIViewController {
    
    
    private var contentView: BonusView {
        view as? BonusView ?? BonusView()
    }
    
    override func loadView() {
        view = BonusView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

