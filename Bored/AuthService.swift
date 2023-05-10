//
//  AuthService.swift
//  Bored
//
//  Created by Intan on 09/05/23.
//

import Foundation

class AuthService {
    
    public static let shared = AuthService()
    private init() {}
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The user information (username, email, password)
    ///   - completion: A completion with two values...
    ///   - Bool: wasRegistered - Determines if the
    public func registerUser(with userRequest: RegisterUserRequest,
                             completion: @escaping (Bool, Error?)->Void){
        let username = userRequest.username
        let email =  userRequest.email
        let password = userRequest.password
        
    }
    
}
