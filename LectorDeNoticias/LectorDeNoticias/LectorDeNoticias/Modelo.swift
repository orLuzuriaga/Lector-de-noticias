//
//  Modelo.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 02/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import CoreData




var noticiasFavoritas = [Noticias]()
var autores = [Int:Autor]()

struct Categoria:Codable{
    let id:Int
    let name:String
}


struct Autor:Codable {
    let id:Int
    let name:String
}



struct Noticias:Codable{
    
    let id:Int
    let date:Date
    let categories:[Int]
    let author:Int
    let link:URL
    var title:Title
    var content:Content
    var excerpt:Excerpt
    let jetpack_featured_media_url:URL
}



struct Title:Codable {
    let rendered:String
}


struct Content:Codable {
    let rendered:String
}

struct Excerpt:Codable {
    let rendered:String
}



extension DateFormatter {
    static let iso8601Full:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }() }






func cargaNoticias(url:URL, callback:@escaping([Noticias]) -> Void) {
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.main.async {
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else{
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let result = try decoder.decode([Noticias].self, from: data)
                    
                    callback(result)
                } catch {
                    print("Error al convertir JSON")
                }
            } else {
                print("Error al cargar los datos")
            }
        }
        
        }.resume()
    
}




func cargaAutor(url:URL, callback:@escaping(Autor) -> Void) {
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.main.async {
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else{
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let result = try decoder.decode(Autor.self, from: data)
                    
                    callback(result)
                } catch {
                    print("Error al convertir JSON Autor")
                }
            } else {
                print("Error al cargar los datos")
            }
        }
        
        }.resume()
    
}



func saveImage(id:Int, image:UIImage) {
    guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let imagenData = image.pngData() else {
        return
    }
    let ruta = folder.appendingPathComponent("imagen_\(id)").appendingPathExtension("png")
    try? imagenData.write(to: ruta, options: .atomicWrite)
}

func loadImage(id:Int) -> UIImage? {
    guard let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }
    let ruta = folder.appendingPathComponent("imagen_\(id)").appendingPathExtension("png")
    if let data = try? Data(contentsOf: ruta) {
        return UIImage(data: data)
    }
    return nil
}






func cargaNoticiasDB(url:URL) {
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.main.async {
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else{
                return
            }
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let result = try decoder.decode([Noticias].self, from: data)
                    result.forEach { noticia in
                        
                        let fetchRequest:NSFetchRequest<PostsDB> = PostsDB.fetchRequest()
                        fetchRequest.predicate = NSPredicate(format: "iD = %@", NSNumber(value: noticia.id))
                        do {
                            let result = try ctx.count(for: fetchRequest)
                            if result == 0 {
                                let newPost = PostsDB(context: ctx)
                                newPost.iD = Int64(noticia.id)
                                newPost.title = noticia.title.rendered
                                newPost.content = noticia.content.rendered
                                newPost.excerpt = noticia.excerpt.rendered
                                newPost.avatarImage = noticia.jetpack_featured_media_url
                                newPost.date = noticia.date
                                
                                // Inicializanos la tabla autor
                                let fetchRequestAutor:NSFetchRequest<AutorDB> = AutorDB.fetchRequest()
                                fetchRequestAutor.predicate = NSPredicate(format: "iD", noticia.author)
                                let resultAutor = try ctx.fetch( fetchRequestAutor)
                                
                                if resultAutor.count == 0{
                                    let num = String(noticia.author)
                                    var url = "https://applecoding.com/wp-json/wp/v2/ users/"
                                    url += num
                                    let link = URL(string: url)
                                    cargaAutor(url: link!) { (autorDecode) in
                                        
                                        let newAutor = AutorDB(context: ctx)
                                           newAutor.iD = Int64(autorDecode.id)
                                           newAutor.name = autorDecode.name
                                    }
                                    
                                }
                              
                            }
                                
                            
                        }catch {
                            print("Error en la consulta \(error)")
                        }
                    }
                    saveContext()
                    
                }catch {
                    print("Error al convertir JSON")
                }
            } else {
                print("Error al cargar los datos")
            }
        }
        
        }
    
}


