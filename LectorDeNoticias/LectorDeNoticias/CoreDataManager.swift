//
//  CoreDataManager.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 10/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import CoreData



class CoreDataManager {
    
    
    
    //MARK - 
     let container: NSPersistentContainer!
    
    
    
   
    
    // Init
    
    init(){
        // Inicializamos el contenedor con el nombre de nuestro modelo
        container = NSPersistentContainer(name: "NoticiasModel")
        
        setupDatabase()
    }
    
    
    // MARK - Private metodos
    
    
   
    
    private func setupDatabase(){
        
        
        
        // Inicializamos y completamos el core data
        container.loadPersistentStores{ (desc, error) in
            
            if let error = error{
                print("Error loading strore \(desc)  - \(error)")
                return
            }
            print("Data base ready")
        }
    
    }
    
    
    // Creamos y guardamos nuestra noticia favorita en la bases de datos
    
    func createFav(id:Int, imagen:URL, categoria:String, data:Date,
                   excerpt:String, title:String, autor:String) -> Void{
        
        //Obtenemos nuestro contexto para poder interactuar con la BBDD
        
        let context = container.viewContext
        
        let noticiaFav = FavoritosDB(context: context)
        noticiaFav.autor = autor
        noticiaFav.avatarImage = imagen
        noticiaFav.categoria = categoria
        noticiaFav.excerpt = excerpt
        noticiaFav.iD = Int64(id)
        noticiaFav.title = title
        
        
        do{
            
            try context.save()
            print("Usuario \(title) guardado")
            
        }catch{
            print("Error guardando la noticia favorita - \(error)")
        }
        
    }
    
    
  
    
    // Obtenemos las noticias favoritas
    func fetchFav() -> [FavoritosDB] {
        
        let fetchRequest:NSFetchRequest<FavoritosDB> = FavoritosDB.fetchRequest()
        
        do{
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        }catch{
            
            print("El error obteniendo la noticia")
        }
            return []
    }
    
    

    
}
