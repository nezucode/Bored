//
//  RegisterController.swift
//  Bored
//
//  Created by Intan on 02/05/23.
//

import UIKit

class RegisterController: UIViewController {
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Getting Started", subTitle: "Create account to continue.")
    private let nameField = CustomTextField(fieldType: .name)
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let createButton = CustomButton(title: "Create Account", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .med)
    
    private let termTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Condition and you acknowledge that you have read our Privacy Policy.")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Condition"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemGray]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.termTextView.delegate = self
        self.view.backgroundColor = .systemBackground
        self.createButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(nameField)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(createButton)
        self.view.addSubview(termTextView)
        self.view.addSubview(signInButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        termTextView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.nameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            self.nameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.nameField.heightAnchor.constraint(equalToConstant: 48),
            self.nameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.usernameField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            self.usernameField.centerXAnchor.constraint(equalTo: nameField.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 48),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            self.emailField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 48),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            self.passwordField.centerXAnchor.constraint(equalTo: emailField.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 48),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.createButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            self.createButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            self.createButton.heightAnchor.constraint(equalToConstant: 48),
            self.createButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.termTextView.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 12),
            self.termTextView.centerXAnchor.constraint(equalTo: createButton.centerXAnchor),
            self.termTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: termTextView.bottomAnchor, constant: 8),
            self.signInButton.centerXAnchor.constraint(equalTo: termTextView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 32),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    //MARK: - Selectors
    @objc private func createAccount(){
        let registerUserRequest = RegisterUserRequest(
            name: self.nameField.text ?? "",
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Username Check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsername(on: self)
            return
        }
        
        // Email Check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmail(on: self)
            return
        }

        // Password Check
        if !Validator.isValidPassword(for: registerUserRequest.password) {
            AlertManager.showInvalidPassword(on: self)
            return
        }
        
        print(registerUserRequest)
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }

            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
            
            print("DEBUG: Successfully created user and uploaded user info")
        }

    }
    
    @objc private func didTapSignIn(){
        let lc = LoginController()
        let navVC = UINavigationController(rootViewController: lc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

}

extension RegisterController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=id")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=id")
        }
        return true
    }
    
    private func showWebViewerController(with urlString: String){
        let vc = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}
