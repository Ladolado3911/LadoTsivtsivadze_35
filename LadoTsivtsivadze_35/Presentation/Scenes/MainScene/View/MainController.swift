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
    
//    var data: [Post]? {
//        print("in data")
//        guard let user = usersManager.loggedInUser else { return nil }
//        let userPosts = postsManager.getUserPosts(user: user)
//        //let everyPosts = postsManager.posts
//        //print(everyPosts)
//        return userPosts
//    }
    var data = [Post]()
    
    private lazy var changeController: ChangerController = {
        let vc = getController(storyboardID: .main, controllerID: .Changer) as? ChangerController
        return vc!
    }()
    
    private lazy var loginController: LoginController = {
        let vc = getController(storyboardID: .login, controllerID: .LoginScene) as? LoginController
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
        configTableView()
        postsManager.clearPosts()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //refresh()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func refresh() {
        postsManager.getPosts { posts in
            self.data = posts
            self.tblView.reloadData()
        }
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
        vc.controllerPointer = self
        pushController(from: self, to: vc, method: .withBackItem)
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
        usersManager.logOut()
        print(usersManager.loggedInUsers!.map { $0.username })
        
        if navigationController!.viewControllers.count == 1 {
            let vc = loginController
            pushController(from: self, to: loginController, method: .withBackItem)
        }
        else {
            popController(from: self, method: .withBackItem)
        }
    }
}

extension MainController: Table {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        
        let post = data[indexPath.row]
        print(data)
        cell!.post = post

        //print("trying tp return cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let post = data[indexPath.row]
        let loggedInUser = usersManager.loggedInUser

        if loggedInUser == post.user {
            let action = UIContextualAction(style: .normal, title: "edit") { action, view, completion in
                action.backgroundColor = .blue
                print("time to edit")
                let vc = self.changeController
                
                vc.editingMode = .editPost
                vc.titleTextView.text = post.title
                vc.contentTextView.text = post.content
                vc.post = post
                
                pushController(from: self, to: vc, method: .withBackItem)
                
            }
            let config = UISwipeActionsConfiguration(actions: [action])
            return config
        }
        else {
            return nil
        }
    }
}

