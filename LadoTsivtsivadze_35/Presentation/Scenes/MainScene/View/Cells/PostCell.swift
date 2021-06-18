//
//  PostCell.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import UIKit
import Kingfisher

class PostCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    var picData: Data?
    var title2: String?
    var content2: String?
    
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let post2 = post else { return }
        
        if let picData = post2.picture {
            let img = UIImage(data: picData)
            picture.image = img
        }
        else {
            print("Could not set image")
        }
        
        if let ttl = post2.title {
            title.text = ttl
        }
        
        if let cnt = post2.content {
            content.text = cnt
        }
    }
}
