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
    private var postsManager: PostsManager!
    private var viewModel: MainViewModel!
    
    private var data: [Post]? {
        guard let user = usersManager.loggedInUser else { return nil }
        let userPosts = postsManager.getUserPosts(user: user)
        let everyPosts = postsManager.posts
        print("this")
        print(everyPosts)
        return everyPosts
    }
    
    private lazy var changeController: ChangerController = {
        let vc = getController(storyboardID: .main, controllerID: .Changer) as? ChangerController
        return vc!
    }()
    
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
        print("this")
        print(data!.map {
            $0.title
        })
        tblView.reloadData()
        print(usersManager.loggedInUsers!.map { $0.username })
    }
    
    func configViewModel() {
        persistantManager = PersistantManager()
        postsManager = PostsManager(with: persistantManager)
        usersManager = UsersManager(with: persistantManager)
        viewModel = MainViewModel(with: usersManager, rootController: self)
    }
    
    func configTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "PostCell")
    }
    
    @IBAction func onNewPost(_ sender: Any) {
        let vc = changeController
        vc.editingMode = .newPost
        vc.postsManager = postsManager
        vc.usersManager = usersManager
        pushController(from: self, to: vc, method: .withBackItem)
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
        guard let data = data else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

