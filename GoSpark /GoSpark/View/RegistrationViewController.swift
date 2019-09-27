//
//  RegistrationViewController.swift
//  GoSpark
//
//  Created by Sarwesh on 26/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,ResponseDelegate {
 
    
    //MARK:- Outlets

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var mobileNumberField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var passwordShowBtn: UIButton!
    @IBOutlet var confirmPasswordShowBtn: UIButton!
    @IBOutlet var createAccountBtn: UIButton!
    
    //MARK:- viewModel

    var registerViewModel = RegisterViewModel()
   
    //MARK:- controller Methods
    override func viewDidLoad() {
        self.title = "GoSpark"
        super.viewDidLoad()
        self.setUpLayouts()
        createAccountBtn.layer.borderWidth = 2.0
        createAccountBtn.layer.cornerRadius = 5
        createAccountBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK:- layout Methods
    func setUpLayouts() {
        nameTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        confirmPasswordTextField.addBottomBorder()
        mobileNumberField.addBottomBorder()
        genderTextField.addBottomBorder()
    }
    
    //MARK:- IBActions

    @IBAction func createAccountClicked(_ sender: Any) {
        if isValidationsDone() {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            createAccountBtn.isUserInteractionEnabled = false
            registerViewModel.delegate = self
            registerViewModel.performRegister(getRegisterRequest())
        }
        
    }
    
    
    @IBAction func showPasswordBtnClicked(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        if !passwordTextField.isSecureTextEntry {
        passwordShowBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
        } else {
            passwordShowBtn.setImage(UIImage(named: "showpassword"), for: .normal)
        }
    }
    @IBAction func genderClicked(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Select Gender", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (alert) in
            self.genderTextField.text = "Male"
        }))
        alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (alert) in
            self.genderTextField.text = "Female"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func showConfirmPasswordBtnClicked(_ sender: Any) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        if !confirmPasswordTextField.isSecureTextEntry {
        confirmPasswordShowBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
        } else {
            confirmPasswordShowBtn.setImage(UIImage(named: "showpassword"), for: .normal)
        }
    }
    
    //MARK:- custom methods
    func getRegisterRequest() -> RegisterRequest {
        return RegisterRequest(name: nameTextField.text ?? "" , email: emailTextField.text ?? "", password: passwordTextField.text ?? "", passwordConfirmation: confirmPasswordTextField.text ?? "", mobile: mobileNumberField.text ?? "", gender: genderTextField.text ?? "")
    }
    
    func isValidationsDone() -> Bool {
        var errorMsg = "please enter "
        var errorsCount = 0
        
        if nameTextField.text == "" {
            errorMsg += "name "
            errorsCount += 1
        }
        if emailTextField.text == "" {
            if errorsCount > 0 {
                errorMsg += "and "
            }
            errorsCount += 1
            errorMsg += "email "
        }
        if passwordTextField.text == "" {
            if errorsCount > 0 {
                errorMsg += "and "
            }
            errorsCount += 1
            errorMsg += "password "
        }
        if confirmPasswordTextField.text == "" {
            if errorsCount > 0 {
                errorMsg += "and "
            }
            errorsCount += 1
            errorMsg += "confirm password "
        }
        if mobileNumberField.text == "" {
            if errorsCount > 0 {
                errorMsg += "and "
            }
            errorsCount += 1
            errorMsg += "mobile number "
        }
        if genderTextField.text == "" {
                   if errorsCount > 0 {
                       errorMsg += "and "
                   }
                   errorsCount += 1
                   errorMsg += "gender "
               }
        
        if errorsCount == 0 {
            if emailTextField.text!.isValidEmail {
                if passwordTextField.text! != confirmPasswordTextField.text {
                    showAlert(message: "Password confirmation is not matching")
                    return false
                }
                return true
            } else {
                showAlert(message: "please enter valid email")
                return false
            }
        }
        showAlert(message: errorMsg)
        return false
    }
    //MARK:- response Delegate conformation

    func responseReceived() {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.createAccountBtn.isUserInteractionEnabled = true
            guard let response = self.registerViewModel.registerResponse else { return }
            if let status = response.status, status == "true" {
            self.navigationController?.popViewController(animated: true)
            }
            self.showAlert(message: response.message ?? "")
        }
     }
}
