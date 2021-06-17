//
//  MainViewModel.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import CoreData
import UIKit

protocol MainViewModelProtocol: AnyObject {
    func testIfLoggedIn() -> Bool
    
    init(with object: UsersManager, rootController controller1: MainController)
}

final class MainViewModel: MainViewModelProtocol {
    
    private var rootController: MainController!
    private var usersManager: UsersManager!
    private lazy var loginController: LoginController = {
        let vc = getController(storyboardID: .login, controllerID: .LoginScene) as? LoginController
        vc!.navigationItem.hidesBackButton = true
        return vc!
    }()
    
    init(with object: UsersManager, rootController controller1: MainController) {
        rootController = controller1
        usersManager = object
    }
    
    func testIfLoggedIn() -> Bool {
        if let loggedInUser = usersManager.loggedInUser {
            return true
        }
        else {
            return false
        }
    }
    
    func goToLogIn() {
        pushController(from: rootController, to: loginController, method: .withBackItem)
    }
}
