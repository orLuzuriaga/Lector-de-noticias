//
//  CollectionViewController.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 02/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import CoreData


class CollectionViewController: UICollectionViewController, UITabBarDelegate {

  
    // Actualizar los datos con UIRefreshControl
    
    lazy var refreshControl:UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action:#selector(self.actualizarDatos(_:)),for:.valueChanged)
        // Establecemos el color de la ruletaUIRefreshControl
        refreshControl.tintColor = UIColor.blue
        self.collectionView.alwaysBounceVertical = true
        return refreshControl
    }()
    
    
    
    
    
    
    var favPosts = [Noticias]()
    
    //MARK - private
     private let manager = CoreDataManager()
    
    
    
    @objc func actualizarDatos(_ refreControl: UIRefreshControl){
        favPosts = noticiasFavoritas
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    
    
    override func viewDidLoad() {
        favPosts = noticiasFavoritas
        super.viewDidLoad()
        self.collectionView.addSubview(self.refreshControl)
        
    }

    
    


    
 
  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return noticiasFavoritas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zeldaFavorito", for: indexPath) as! CollectionViewCell
        
        
        
        
        let dato = favPosts[indexPath.row]

        cell.titleFav?.text? = String(dato.title.rendered)
       /*
        var url = "https://applecoding.com/wp-json/wp/v2/users/"
        url += String(dato.author)
        
        let link = URL(string: url)
        
        cargaAutor(url: link!) { (autor) in
            
            cell.autorFav?.text? = autor.name
           
        }*/
        if let nombreAutor = autores[dato.author]{
            
            cell.autorFav?.text = nombreAutor.name
        }
        
        
     
        
        if let imagen = loadImage(id: dato.id) {
            //Utilizo encadenamiento opcional
               cell.imagenFav?.image = imagen
        } else {
            getImage(url: dato.jetpack_featured_media_url) { imagen in
                DispatchQueue.main.async {
                    let visible = collectionView.indexPathsForVisibleItems
                    if visible.contains(indexPath)  {
                        cell.imagenFav?.image = imagen
                        saveImage(id: dato.id, image: imagen)
                    }
                }
            }
        }
    
    
        return cell
    }

    
    
 
    // MARK: UICollectionViewDelegate



    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

*/
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let text = item.title, text == "Favoritos"{
            
                print("Estoy en favoritos")

            
        }
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDetalleController" {
            guard let destino = segue.destination as? DetalleViewController,
                let origen = sender as? CollectionViewCell,
                let indexPath = collectionView.indexPath(for: origen) else {
                    return
            }
            
            destino.detalleNoticia = noticiasFavoritas[indexPath.row]
            
        }
    }
    
    
    
}

 
