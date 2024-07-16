//
//  InfoVC.swift

import Foundation
import UIKit

class InfoVC: UIViewController {
    
    
    private var contentView: InfoView {
        view as? InfoView ?? InfoView()
    }
    
    override func loadView() {
        view = InfoView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

