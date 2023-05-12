//
//  AlertManager.swift
//  Bored
//
//  Created by Intan on 08/05/23.
//

import UIKit

class AlertManager {
    private static func showBasicAlert(on vc: UIViewController, title: String, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

//MARK: - Show Validation Alert
extension AlertManager {
    public static func showInvalidUsername(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username.")
    }
    public static func showInvalidEmail(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email address.")
    }
    
    public static func showInvalidPassword(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
}

//MARK: - Registration Error
extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Log In Error
extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: "\(error.localizedDescription)")
    }
}

//MARK: - Log Out Error
extension AlertManager {
    public static func showLogoutErrorAlert(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot Password
extension AlertManager {
    public static func showPasswordResetSent(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

//MARK: - Fetching User Errors
extension AlertManager {
    public static func showUnknownFetchingUserError(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showFetchingUserError(on vc: UIViewController, with error: Error){
        self.showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: "\(error.localizedDescription)")
    }
}

