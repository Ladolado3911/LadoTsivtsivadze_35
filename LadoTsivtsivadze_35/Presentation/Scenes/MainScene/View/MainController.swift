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
    
    var data: [Post]? {
        print("in data")
        //guard let user = usersManager.loggedInUser else { return nil }
        //let userPosts = postsManager.getUserPosts(user: user)
        let everyPosts = postsManager.posts
        //print(everyPosts)
        return everyPosts
    }
    
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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
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
        if let data = data {
            print("unwrapped")
            return data.count
        }
        else {
            print("can not unwrap")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else {
            print("did not unwrap")
            return PostCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell
        
        let post = data[indexPath.row]
        cell!.title2 = post.title
        cell!.content2 = post.content
        cell!.picData = post.picture

        //print("trying tp return cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

