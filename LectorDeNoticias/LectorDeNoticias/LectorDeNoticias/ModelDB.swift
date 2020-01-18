//
//  ModelDB.swift
//  LectorDeNoticias
//
//  Created by Dev1 on 10/09/2019.
//  Copyright © 2019 RenatoLuzuriaga. All rights reserved.
//

import UIKit
import CoreData

var persistentContainer:NSPersistentContainer = {
    let container = NSPersistentContainer(name: "NoticiasModel")
    container.loadPersistentStores { store, error in
        if let error = error as NSError? {
            fatalError("No se ha podido abrir la base de datos")
        }
    }
    return container
}()

var ctx:NSManagedObjectContext {
    return persistentContainer.viewContext
}

func saveContext() {
    DispatchQueue.main.async {
        if ctx.hasChanges {
            do {
                try ctx.save()
            } catch {
                print("Error en el commit \(error)")
            }
        }
    }
}
