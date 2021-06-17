//
//  LoginController.swift
//  LadoTsivtsivadze_35
//
//  Created by lado tsivtsivadze on 6/17/21.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var persistantManager: PersistentManagerProtocol!
    private var usersManager: UsersManager!
    private var viewModel: LoginViewModel!
    
    override func loadView() {
        super.loadView()
        
        if navigationController!.viewControllers.count == 2 {
            print("count is 2")
            navigationItem.hidesBackButton = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.title = "Log in"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        usersManager = UsersManager(with: persistantManager)
        viewModel = LoginViewModel(with: usersManager, rootController: self)
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        if usernameField.text == "" || passwordField.text == "" {
            return
        }
        usersManager.users!.map { print($0.username) }
        viewModel.login(username: usernameField.text!, password: passwordField.text!)
    }

    @IBAction func onRegister(_ sender: Any) {
        viewModel.goToRegister()
    }
}
