//
//  AcercaDeTableViewCell.swift
//  LectorDeNoticias
//
//  Created by Renato on 15/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit

class AcercaDeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    
    
    
    override func prepareForReuse() {
        
        nombre = nil
        infoImage = nil
      
        
        
    }
    
  

}
