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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let picData = picData else { return }
        guard let title2 = title2 else { return }
        guard let content2 = content2 else { return }

        let img = UIImage(data: picData)
        picture.image = img
        title.text = title2
        content.text = content2
    }
}
