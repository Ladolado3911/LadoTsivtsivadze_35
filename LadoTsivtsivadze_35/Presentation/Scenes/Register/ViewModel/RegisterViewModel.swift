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
    
    init(with object: UsersManagerProtocol, rootController controller1: RegisterController)
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    private var usersManager: UsersManagerProtocol!
    private var rootController: RegisterController!
    
    private lazy var loginController: LoginController = {
        let vc = getController(storyboardID: .login, controllerID: .LoginScene) as? LoginController
        vc!.modalPresentationStyle = .fullScreen
        return vc!
    }()
    
    init(with object: UsersManagerProtocol, rootController controller1: RegisterController) {
        usersManager = object
        rootController = controller1
    }
    
    func register(username name: String, password pass: String) {
        usersManager.register(usingPassword: pass, usingUsername: name) { (success) in
            print("result: \(success)")
            if success {
                self.rootController.present(self.loginController, animated: true, completion: nil)
            }
            else {
                print("Can not modal")
            }
        }
    }
}
