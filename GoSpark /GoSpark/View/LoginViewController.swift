//
//  LoginViewController.swift
//  GoSpark
//
//  Created by Sarwesh on 26/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController,ResponseDelegate {
    
    //MARK:- Outlets
    @IBOutlet var email: UITextField!
    @IBOutlet var paasword: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var showPasswordBtn: UIButton!
    
    //MARK:- viewModel
    var loginViewModel = LoginViewModel()
    
    //MARK:- controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        email.layer.cornerRadius = 5
        paasword.layer.cornerRadius = 5
        logInButton.layer.borderWidth = 2.0
        logInButton.layer.cornerRadius = 5
        logInButton.layer.borderColor = UIColor.white.cgColor
        self.title = "GoSpark"
        email.addBottomBorder()
        paasword.addBottomBorder()
    }
    
    //MARK:- IBActions
    @IBAction func showPasswordBtnClicked(_ sender: Any) {
        paasword.isSecureTextEntry.toggle()
        if !paasword.isSecureTextEntry {
        showPasswordBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
        } else {
            showPasswordBtn.setImage(UIImage(named: "showpassword"), for: .normal)
        }
    }
    @IBAction func loginClicked(_ sender: Any) {
        if isValidationsDone() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        logInButton.isUserInteractionEnabled = false
        loginViewModel.delegate = self
        loginViewModel.performLogin(email: email.text ?? "", password: paasword.text ?? "")
        email.text = ""
        paasword.text = ""
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- custom methods
    func isValidationsDone() -> Bool {
        if email.text == "" && paasword.text == "" {
            showAlert(message: "Enter email and password")
            return false
        } else if email.text == ""{
            showAlert(message: "Enter email")
            return false
        } else if paasword.text == ""{
            showAlert(message: "Enter password")
            return false
        } else if !email.text!.isValidEmail {
            showAlert(message: "Enter a valid email")
            return false
        }
        return true
    }
    func changeRootViewController() {
        let vc = NewsFeedViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    //MARK:- response Delegate conformation
    func responseReceived() {
        DispatchQueue.main.async {
       UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.logInButton.isUserInteractionEnabled = true
            guard let response = self.loginViewModel.loginResponse else { return }
             if response.status == "true",let user = response.user {
             UserDefaults.standard.set(user.apiToken, forKey: "token")
            self.changeRootViewController()
            } else {
                self.showAlert(message: response.message ?? "")
             }
        }
    }
}
extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UITextField {
    
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.bounds.height - 1, width: UIScreen.main.bounds.width - 40, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
}
extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
