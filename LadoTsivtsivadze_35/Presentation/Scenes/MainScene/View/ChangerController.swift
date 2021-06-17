//
//  ChangerController.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import UIKit

enum EditingMode {
    case editPost
    case newPost
}

class ChangerController: UIViewController {
    
    var editingMode: EditingMode?
    var controllerPointer: MainController?
    var post: Post?
    var newPost: Post?
    
    var postsManager: PostsManager?
    var usersManager: UsersManager?
    
    var tempImgData: Data?
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clear()
    }

    func setTitle() {
        switch editingMode {
        case .newPost:
            title = "New Note"

        case .editPost:
            title = "Edit Note"
            setPostIfNeeded()
        default:
            title = "No Note"
        }
    }
    
    func clear() {
        titleTextView.text = ""
        contentTextView.text = ""
    }
    
    func setPostIfNeeded() {
        guard let post = post else { return }
        titleTextView.text = post.title
        contentTextView.text = post.content
    }
    
    @IBAction func onChooseImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        //vc.allowsEditing = true
        self.present(vc, animated: true)
    }
    
    @IBAction func onUploadPost(_ sender: UIButton) {
        guard let userManager = usersManager else { return }
        guard let postManager = postsManager else { return }
        guard let tempImgData = tempImgData else { return }
        
        if titleTextView.text == "" || contentTextView.text == "" {
            return
        }
        print("Upload")
        let loggedinUser = userManager.loggedInUser

        newPost = postManager.newPost(title: self.titleTextView.text,
                                       content: self.contentTextView.text,
                                       image: tempImgData)

        loggedinUser?.addToPosts(newPost!)
    }
}

extension ChangerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        DispatchQueue.global(qos: .utility).async {
            
            let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    //self.img.image = image
                    guard let image = image else { return }
                    let imgData = image.pngData()
                    self.tempImgData = imgData
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
