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
    
    init(with object: UsersManagerProtocol, rootController controller1: LoginController)
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private var usersManager: UsersManagerProtocol!
    private var rootController: LoginController!
    
    private lazy var mainController: MainController = {
        let vc = getController(storyboardID: .main, controllerID: .mainScene) as? MainController
        vc!.navigationItem.hidesBackButton = true
        return vc!
    }()
    
    private lazy var registerController: RegisterController = {
        let vc = getController(storyboardID: .register, controllerID: .RegisterScene) as? RegisterController
        return vc!
    }()
    
    init(with object: UsersManagerProtocol, rootController controller1: LoginController) {
        usersManager = object
        rootController = controller1
    }
    
    func login(username name: String, password pass: String) {
        // create code here
        usersManager.login(usingPassword: pass,
                           usingUsername: name) { (success) in
            if success {
                print("can log in")
                pushController(from: self.rootController, to: self.mainController, method: .withBackItem)
            }
            else {
                print("can not log in")
            }
        }
    }
    
    func goToRegister() {
        pushController(from: rootController, to: registerController, method: .withBackItem)
    }
}
