//
//  ForgotPassController.swift
//  Bored
//
//  Created by Intan on 02/05/23.
//

import UIKit

class ForgotPassController: UIViewController {

    //MARK: Variables
    
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password.")
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 48),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            self.resetPasswordButton.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.resetPasswordButton.heightAnchor.constraint(equalToConstant: 48),
            self.resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
            
//            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
//            self.signInButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
//            self.signInButton.heightAnchor.constraint(equalToConstant: 48),
//            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
//
//            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 14),
//            self.newUserButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
//            self.newUserButton.heightAnchor.constraint(equalToConstant: 32),
//            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
//
//            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 4),
//            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: newUserButton.centerXAnchor),
//            self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 24),
//            self.forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    //MARK: - Selectors
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
