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
    func getTimeNow() -> String{
        let now = Date()

         let formatter = DateFormatter()

         formatter.timeZone = TimeZone.current

         formatter.dateFormat = "yyyy-MM-dd HH:mm"

         let dateString = formatter.string(from: now)
        return dateString
    }
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
    func pushView<T: UIViewController>(storybard: UIStoryboard, nextView: T.Type, callback: ((T) -> Void)? = nil) {
        let nextView = T(nibName:T.nameClass, bundle: nil)
//        let secondView = storybard.instantiateViewController(withIdentifier: T.nameClass) as? T
        callback?(nextView)
        self.navigationController?.pushViewController(nextView , animated: true)
        
    }
}
extension UIButton {
    func setContrainLabel(_ top: CGFloat, _ leading: CGFloat, _ bottom: CGFloat, _ training: CGFloat ){
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self as Any,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem:  self.titleLabel,
                           attribute: .top,
                           multiplier: 1,
                           constant: top).isActive = true
        NSLayoutConstraint(item: self as Any,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem:  self.titleLabel,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leading).isActive = true
        NSLayoutConstraint(item: self as Any,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem:  self.titleLabel,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: bottom).isActive = true
        NSLayoutConstraint(item: self as Any,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem:  self.titleLabel,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: training).isActive = true
        self.titleLabel?.numberOfLines = 0
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
