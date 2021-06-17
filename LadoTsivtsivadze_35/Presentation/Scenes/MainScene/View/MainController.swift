//
//  ViewController.swift
//  LadoTsivtsivadze_35
//
//  Created by lado tsivtsivadze on 6/17/21.
//

import UIKit

class MainController: UIViewController {

    private var persistantManager: PersistentManagerProtocol!
    private var usersManager: UsersManager!
    private var viewModel: MainViewModel!
    
    override func loadView() {
        super.loadView()
        configViewModel()
        if viewModel.testIfLoggedIn() {
            
        }
        else {
            viewModel.goToLogIn()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        usersManager = UsersManager(with: persistantManager)
        viewModel = MainViewModel(with: usersManager, rootController: self)
    }

    @IBAction func onLogin(_ sender: UIButton) {
    }
    
}

