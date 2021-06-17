//
//  RegisterViewModel.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import CoreData
import UIKit

protocol RegisterViewModelProtocol: AnyObject {
    func register(username name: String, password pass: String)
    
    init(with object: UsersManagerProtocol)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    private var usersManager: UsersManagerProtocol!
    
    func register(username name: String, password pass: String) {
        usersManager.register(usingPassword: pass, usingUsername: name) { (success) in
            print("result: \(success)")
        }
    }
    
    init(with object: UsersManagerProtocol) {
        usersManager = object
    }
}
