//
//  Font + Extension.swift


import Foundation
import UIKit

extension UIFont {
    
    enum CustomFonts: String {
        case author = "AuthorVariable-Bold"
        case sup = "sup"
    }
    
    enum CustomFontStyle: String {
        case regular = "_Regular"
        case ercharge = "ercharge"
        case medium = "_Medium"
    }
    
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: Int,
        isScaled: Bool = true) -> UIFont {
            
            let fontName: String = font.rawValue + style.rawValue
            
            guard let font = UIFont(name: fontName, size: CGFloat(size)) else {
                debugPrint("Font can't be loaded")
                return UIFont.systemFont(ofSize: CGFloat(size))
            }
            
            return isScaled ? UIFontMetrics.default.scaledFont(for: font) : font
        }
}

extension UIImageView {
    func saveImageToLocal(image: UIImage, userID: String) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(userID).png")
            try? data.write(to: fileURL)
        }
    }
    
    func getImageFromLocal(userID: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(userID).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension UILabel {
    static func createLabel(withText text: String, font: UIFont, textColor: UIColor, paragraphSpacing: CGFloat, lineHeightMultiple: CGFloat, kern: CGFloat = 0.0, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = textAlignment
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .kern: kern,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString
        
        return label
    }
}

extension UILabel {
    func setGradientText(colors: [UIColor]) {
        // Обновляем layout, чтобы получить правильные размеры
        self.layoutIfNeeded()

        // Убеждаемся, что размеры ненулевые
        guard self.bounds.size != .zero else { return }

        // Создаем CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        // Создаем image из gradient layer используя UIGraphicsImageRenderer
        let renderer = UIGraphicsImageRenderer(bounds: gradientLayer.bounds)
        let gradientImage = renderer.image { context in
            gradientLayer.render(in: context.cgContext)
        }

        // Устанавливаем gradient image как текстовый цвет
        self.textColor = UIColor(patternImage: gradientImage)
    }
}

extension UITextView {
    static func createTextView(withText text: String, font: UIFont, textColor: UIColor, paragraphSpacing: CGFloat, lineHeightMultiple: CGFloat, textAlignment: NSTextAlignment = .center) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = textAlignment
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textView.attributedText = attributedString
        
        return textView
    }
}
