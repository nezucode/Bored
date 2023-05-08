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
            let alert = UIAlertController(title: "title", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

//MARK: - Show Validation Alert
extension AlertManager {
    public static func showInvalidEmail(on vc: UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email address")
    }
}
