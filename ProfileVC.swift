//
//  ProfileVC.swift

import Foundation
import UIKit
import SnapKit

class ProfileVC: UIViewController, UITextFieldDelegate {
    
    
    private let imagePicker = UIImagePickerController()
    private var fullScreenView: UIView?

    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePicker()
        buttonsActive()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFotoLoad()
        updateLabel()
    }
    
    private func configurePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    
    private func updateLabel() {
        contentView.analyticViewThree.titleLabel.text = "\(MemoryApp.shared.scorePoints)"
        contentView.analyticViewOne.titleLabel.text = "\(MemoryApp.shared.passedTheQuiz)"
        contentView.analyticViewTwo.titleLabel.text = "\(MemoryApp.shared.failedQuiz)"
    }
    
    private func buttonsActive() {
        contentView.btnName.addTarget(self, action: #selector(tappeUpdateName), for: .touchUpInside)
        contentView.btnPhoto.addTarget(self, action: #selector(photoTake), for: .touchUpInside)

    }
    
    private func checkFotoLoad() {
           if let userID = MemoryApp.shared.userID, let savedImage = contentView.imgUserPhoto.getImageFromLocal(userID: String(userID)) {
               contentView.imgUserPhoto.image = savedImage
           }
       }
    
    @objc func photoTake() {
        let alert = UIAlertController(title: "Pick Library", message: nil, preferredStyle: .actionSheet)
        
        let actionLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func tappeUpdateName() {
        presentModalView()
    }
    
    private func presentModalView() {
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
            
            let imageBonusView = UIImageView(image: .imgNameCont)
            imageBonusView.contentMode = .scaleToFill
            imageBonusView.layer.shadowColor = UIColor(red: 1, green: 0.379, blue: 0.295, alpha: 0.8).cgColor
            imageBonusView.layer.shadowOpacity = 1
            imageBonusView.layer.shadowRadius = 35
            imageBonusView.layer.shadowOffset = CGSize(width: 0, height: 2)
            viewConteiner.addSubview(imageBonusView)
            
            
            let titleLabel = GradientLabel()
            titleLabel.text = "What’s your\nname?"
            titleLabel.font = .customFont(font: .sup, style: .ercharge, size: 20)
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.gradientColors = [.cBiegeGradOne, .cBiegeGradTwo]
            viewConteiner.addSubview(titleLabel)
            
            let textField = UITextField()
            let font = UIFont.customFont(font: .sup, style: .ercharge, size: 20)
            
            let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
            
            let placeholderText = NSAttributedString(string: "Enter your name", attributes: placeholderAttributes)
            textField.attributedPlaceholder = placeholderText
            
    
            
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.white,
            ]
            textField.font = UIFont.customFont(font: .sup, style: .ercharge, size: 20)
            textField.textColor = .white
            textField.backgroundColor = .clear
            textField.textAlignment = .center
            textField.delegate = self
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.cornerRadius = 6
            viewConteiner.addSubview(textField)

            let thanksBtn = UIButton()
            thanksBtn.setBackgroundImage(.btnSave, for: .normal)
            thanksBtn.setBackgroundImage(.btnSaveSelect, for: .highlighted)
            thanksBtn.addTarget(self, action: #selector(tappedCloseBuy), for: .touchUpInside)
            fullScreenView!.addSubview(thanksBtn)
            
            viewConteiner.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().offset(-60)
                make.height.equalTo(269)
                make.width.equalTo(329)
            }
            
            imageBonusView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.top.equalToSuperview().offset(32)
            }
            
            textField.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(16)
                make.height.equalTo(50)
                make.width.equalTo(265)
            }
        
            thanksBtn.snp.makeConstraints { make in
                make.top.equalTo(textField.snp.bottom).offset(-12)
                make.centerX.equalToSuperview()
                make.width.equalTo(332)
                make.height.equalTo(128)
            }
            
            self.view.addSubview(fullScreenView!)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView!.alpha = 1
        })
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        MemoryApp.shared.userName = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Клавиатура спрятана")
        updateName()
        return true
    }
    
    @objc func tappedCloseBuy() {
        UIView.animate(withDuration: 0.5, animations: {
            self.fullScreenView?.alpha = 0
        }) { _ in
            self.fullScreenView?.removeFromSuperview()
            self.fullScreenView = nil
            self.contentView.nameLabel.text = "\(MemoryApp.shared.userName ?? "User Name")"
            self.updateName()
        }
    }
    
    func updateName() {
      
        if MemoryApp.shared.userName != nil {
            let payload = UpdatePayload(name: MemoryApp.shared.userName, score: nil)
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
    }
}

extension ProfileVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            contentView.imgUserPhoto.image = image
            if let userID = MemoryApp.shared.userID {
                contentView.imgUserPhoto.saveImageToLocal(image: image, userID: String(userID))
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: UINavigationControllerDelegate {
    
}
