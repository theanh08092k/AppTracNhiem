//
//  Extention.swift
//  AppTracNhiem
//
//  Created by V000315 on 17/08/2022.
//

import Foundation
import UIKit
extension NSObject {
    public class var nameClass: String {
        return String(describing: self)
    }
}
extension UIViewController {
    func showAlert(title: String, infor: String, callback: (()-> Void)? = nil){
        let alert = UIAlertController(title: title,
                                      message: infor,  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            callback?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func presentNextView<T : UIViewController>(storyboard: UIStoryboard? = nil, nextView: T.Type){
        let storyboard = storyboard == nil ? self.storyboard : storyboard
        guard let nextV = storyboard?.instantiateViewController(withIdentifier: T.nameClass) as? T else{
            return
        }
        nextV.modalTransitionStyle = .flipHorizontal
        nextV.modalPresentationStyle = .fullScreen
        self.present(nextV, animated: true, completion: nil)
    }
}
extension UITextField {
    func setDefautText(text: String, color: UIColor, corner: Int? = nil) {
        if corner != nil {
            self.layer.cornerRadius = CGFloat(corner ?? 5)
        } else {
            self.layer.cornerRadius = CGFloat(corner ?? 5)
        }
        self.attributedPlaceholder =
        NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
extension UILabel {
    func addActionClick(_ view: UIViewController, action: Selector){
        let tap = UITapGestureRecognizer(target: view, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
}
