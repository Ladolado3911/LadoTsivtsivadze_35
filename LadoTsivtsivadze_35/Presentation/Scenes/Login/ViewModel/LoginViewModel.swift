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
    
    func login(username name: String, password pass: String) {
        // create code here
    }
    
    init(with object: UsersManagerProtocol) {
        usersManager = object
    }
}
