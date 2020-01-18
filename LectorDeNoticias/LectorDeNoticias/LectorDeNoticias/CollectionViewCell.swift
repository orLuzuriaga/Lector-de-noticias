//
//  CollectionViewCell.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 11/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var imagenFav: UIImageView!
    @IBOutlet weak var titleFav: UILabel!
    @IBOutlet weak var autorFav: UILabel!
    
    override func prepareForReuse() {
        
        imagenFav = nil
        titleFav = nil
        autorFav = nil
        
       
    }
    
    
}
