//
//  RegisterController.swift
//  LadoTsivtsivadze_35
//
//  Created by lado tsivtsivadze on 6/17/21.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var persistantManager: PersistentManagerProtocol!
    private var usersManager: UsersManagerProtocol!
    private var viewModel: RegisterViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        usersManager = UsersManager(with: persistantManager)
        viewModel = RegisterViewModel(with: usersManager)
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        if usernameField.text == "" || passwordField.text == "" {
            return
        }
        viewModel.register(username: usernameField.text!,
                           password: passwordField.text!)
    }
}
