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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController!.navigationBar.topItem!.title = "Register"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        usersManager = UsersManager(with: persistantManager)
        viewModel = RegisterViewModel(with: usersManager, rootController: self)
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        if usernameField.text == "" || passwordField.text == "" {
            return
        }
        print("here")
        viewModel.register(username: usernameField.text!,
                           password: passwordField.text!)
    }
}
