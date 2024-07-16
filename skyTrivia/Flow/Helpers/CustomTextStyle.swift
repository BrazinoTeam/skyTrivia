//
//  CustomTextStyle.swift


import Foundation
import UIKit

enum CustomTextStyle {
    case normalAttrString
    case highlightedAttrString
    case labelAttrString
    case titleStartAttrString
    case titleLabelAttrString

    func attributedString(with text: String) -> NSAttributedString {
        switch self {
        case .normalAttrString:
            return NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.strokeColor: UIColor.blue,
                    NSAttributedString.Key.strokeWidth: -7.0,
                    NSAttributedString.Key.font: UIFont.customFont(font: .sup, style: .ercharge, size: 20),
                    NSAttributedString.Key.foregroundColor:  UIColor.white
                ]
            )

        case .highlightedAttrString:
            return NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.strokeColor: UIColor.blue,
                    NSAttributedString.Key.strokeWidth: -5.0,
                    NSAttributedString.Key.font: UIFont.customFont(font: .sup, style: .ercharge, size: 20),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            )
            
        case .labelAttrString:
            return NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.strokeColor: UIColor.cOrange,
                    NSAttributedString.Key.strokeWidth: -8.0,
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            )
            
        case .titleStartAttrString:
            return NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.strokeColor: UIColor.orange,
                    NSAttributedString.Key.strokeWidth: -8.0,
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            )
            
        case .titleLabelAttrString:
            return NSAttributedString(
                string: text,
                attributes: [
                    NSAttributedString.Key.strokeColor: UIColor.white,
                    NSAttributedString.Key.strokeWidth: -5.0,
                    NSAttributedString.Key.foregroundColor: UIColor.blue
                ]
            )
        }
    }
}

