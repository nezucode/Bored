//
//  SceneDelegate.swift
//  Bored
//
//  Created by Intan on 28/03/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        let layout = UICollectionViewFlowLayout()
        let swipingController = SwipingController(collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        self.window?.rootViewController = swipingController
        
//        let userRequest = RegisterUserRequest(
//            username: "nezuko",
//            email: "nezuko@gmail.com",
//            password:"nezuko123"
//        )
//
//        AuthService.shared.registerUser(with: userRequest) { wasRegistered, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            print("wasRegistered", wasRegistered)
//        }
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: winScene.coordinateSpace.bounds)
        window?.windowScene = winScene
        self.window?.makeKeyAndVisible()
    }
    
}

