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
    }
    
    @IBAction func onUploadPost(_ sender: UIButton) {
        
    }
}
