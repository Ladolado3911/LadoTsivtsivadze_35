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
    
    @IBOutlet weak var tblView: UITableView!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(usersManager.loggedInUsers!.map { $0.username })
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        usersManager = UsersManager(with: persistantManager)
        viewModel = MainViewModel(with: usersManager, rootController: self)
    }
    
    func configTableView() {
    
    }

    @IBAction func onLogout(_ sender: UIButton) {
        let loggedInUser = usersManager.loggedInUser
        loggedInUser!.isLoggedin = false
        print(usersManager.loggedInUsers!.map { $0.username })
        popController(from: self, method: .withBackItem)
    }
}

extension MainController: Table {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

