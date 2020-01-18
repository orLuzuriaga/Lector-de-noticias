//
//  TableViewController.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 02/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    
    @IBOutlet weak var buttonFavorito: UIButton!
    
    var noticias = [Noticias]()
    
    //private let manager = CoreDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let link = URL(string: "https://applecoding.com/wp-json/wp/v2/posts?per_page=20")

        
       cargaNoticias(url: link!) { (noticias) in
            self.noticias = noticias
            self.tableView.reloadData()
           }
       
    }
    
    final func getNoticia()-> [Noticias]{
        
        return noticias
    }

    // MARK: - Table view data source

    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noticias.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zeldaNoticias", for: indexPath) as! NoticiasTableViewCell
        let dato = noticias[indexPath.row]
        cell.title.text = String(dato.title.rendered)
        cell.excerpt.text = dato.excerpt.rendered.convertHTML
      
        
        if let imagen = loadImage(id: dato.id) {
            cell.avatarImage.image = imagen
        } else {
            getImage(url: dato.jetpack_featured_media_url) { imagen in
                DispatchQueue.main.async {
                    if let visible = tableView.indexPathsForVisibleRows, visible.contains(indexPath) {
                        cell.avatarImage.image = imagen
                        saveImage(id: dato.id, image: imagen)
                    }
                }
            }
        }
        return cell
    }
   
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dato = noticias[indexPath.row]
        var fav = false
        let action = UIContextualAction(style: .normal, title: "Favorito") {
            action, view, handler in
            
            var urlAutor = "https://applecoding.com/wp-json/wp/v2/users/"
            urlAutor += String(dato.author)
            
            let link = URL(string: urlAutor)
            
            // Añado el autor en mi diccionario
            cargaAutor(url: link!) { (autor) in

                autores[dato.author] = autor
            }
            
            
          /*  var urlCat = " https:// applecoding.com/wp-json/wp/v2/categories"
            urlCat = String(dato.id)
            
            let linkCat   = URL(string: urlCat)
            
         */
            
            //guardo mi noticia favorita
            noticiasFavoritas.append(dato)
            fav = true
           /* self.manager.createFav(id: dato.id, imagen: dato.jetpack_featured_media_url, categoria: "Categoria",
                              data: dato.date, excerpt: String(dato.excerpt.rendered), title: String(dato.title.rendered), autor: "Julio")*/

            let cell = tableView.cellForRow(at: indexPath)
            if fav {
             
                //cell?.backgroundColor = .yellow
                fav.toggle()
               
            } else {
                cell?.backgroundColor = .clear
            }
           
            handler(true)
            
          }
        action.image = UIImage(named: "star")
        if !fav {
            action.backgroundColor = .green
           
        } else {
            action.backgroundColor = .red
        }
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
        
    }

        

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDetalle" {
            guard let destino = segue.destination as? DetalleViewController,
                let origen = sender as? NoticiasTableViewCell,
                let indexPath = tableView.indexPath(for: origen) else {
                    return
            }
            
            destino.detalleNoticia = noticias[indexPath.row]
            
        }
    }
    
    

    
    
 
        
    
    
    
}
