//
//  LoginVCL.swift
//  AppTracNhiem
//
//  Created by V000315 on 16/08/2022.
//

import UIKit

class LoginVCL: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var textAccount: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func clickLogin(_ sender: Any) {
        let user = textAccount.text ?? ""
        FireBase.firebase.checkDataLogin(userName: user) { respone in
            DispatchQueue.main.async { [self] in
                if respone == true && user.count != 0{
                    let nextView = HomeVCL(nibName: "HomeVCL", bundle: nil)
                    nextView.modalPresentationStyle = .fullScreen
                    present(nextView, animated: true)
                } else {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Sai tên tài khoản hoặc mật khẩu.",  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
}
