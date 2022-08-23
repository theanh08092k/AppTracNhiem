//
//  LoginVCL.swift
//  AppTracNhiem
//
//  Created by V000315 on 16/08/2022.
//

import UIKit

class LoginVCL: UIViewController {
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var textAccount: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textAccount.setDefautText(text: "Login with your email", color: .lightGray, corner: 10)
        textPassword.setDefautText(text: "Your email password", color: .lightGray, corner: 10)
        textPassword.isSecureTextEntry = true
        let user = UserDefaults.standard.string(forKey: "UserName")
        let pass = UserDefaults.standard.string(forKey: "PassWord")
        if user != nil && pass != nil {
            textAccount.text = user
            textPassword.text = pass
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func clickRegister(_ sender: Any) {
        let userAccount = textAccount.text ?? ""
        let userPassword = textPassword.text ?? ""
        FireBase.firebase.creatAAcount(email: userAccount, password: userPassword) { [weak self ] respone in
            DispatchQueue.main.async {
                if respone == false {
                    self?.showAlert(title: "Lỗi", infor: "Email đã tồn tại")
                } else {
                    self?.showAlert(title: "Thành công", infor: "Đăng ký tài khoản email thành công")
                }
            }
        }
    }
    @IBAction func clickLogin(_ sender: Any) {
        let user = textAccount.text ?? ""
        let pass = textPassword.text ?? ""
        FireBase.firebase.loginAccount(email: user, password: pass, clousue: { [weak self] respone in
            guard let self = self  else {return}
            DispatchQueue.main.async {
                if respone == false {
                    self.showAlert(title: "Error", infor: "Sai thông tin đăng nhập")
                } else {
                    UserDefaults.standard.set(user, forKey: "UserName")
                    UserDefaults.standard.set(pass, forKey: "PassWord")
                    self.navigationController?.popViewController(animated: true)
                    self.pushView(storybard: UIStoryboard(name: "Main", bundle: nil), nextView: HomeVCL.self) { view  in
                        view.textNameUser = user
                    }
                }
            }
        })
    }
}
