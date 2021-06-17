//
//  LoginViewModel.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import CoreData
import UIKit

protocol LoginViewModelProtocol: AnyObject {
    func login(username name: String, password pass: String)
    
    init(with object: UsersManagerProtocol)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private var usersManager: UsersManagerProtocol!
    
    init(with object: UsersManagerProtocol) {
        usersManager = object
    }
    
    func login(username name: String, password pass: String) {
        // create code here
        usersManager.login(usingPassword: pass,
                           usingUsername: name) { (success) in
            if success {
                print("can log in")
            }
            else {
                print("can not log in")
            }
        }
    }
}
