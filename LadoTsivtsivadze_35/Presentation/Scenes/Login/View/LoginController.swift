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
    private var usersManager: UsersManagerProtocol!
    private var viewModel: LoginViewModel!
    
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
        
    }

    @IBAction func onRegister(_ sender: Any) {
        viewModel.goToRegister()
    }
}
