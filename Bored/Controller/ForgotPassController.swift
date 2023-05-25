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
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        let back = UIImage(systemName: "chevron.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", image: back, target: self, action: #selector(didBackTap))
        
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
    @objc private func didTapForgotPassword(){
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmail(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self) 
        }
        
        //TODO: - Email Validation
        
        
    }
    
    @objc private func didBackTap(){
        let _ = self.dismiss(animated: true, completion: nil)
    }

}
