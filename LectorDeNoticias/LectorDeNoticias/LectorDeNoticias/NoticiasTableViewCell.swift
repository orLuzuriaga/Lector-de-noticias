//
//  NotociasTableViewCell.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 02/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit

class NoticiasTableViewCell: UITableViewCell {

    
    // MARK: - Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var excerpt: UILabel!
    
    override func prepareForReuse() {
        title.text = nil
        excerpt.text = nil
        content = nil
        avatarImage.image = nil
    }
    
    

}
