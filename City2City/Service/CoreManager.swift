//
//  CoreManager.swift
//  City2City
//
//  Created by mac on 5/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData


let coreManager = CoreManager.sharedInstance

final class CoreManager {
    
    static let sharedInstance = CoreManager()
    private init() {}
    
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.Keys.City2City.rawValue)
        
        
        container.loadPersistentStores(completionHandler: { (persistentStore, err) in
            if let error = err {
                fatalError("Ya messed up")
            }
        })
        
        
        return container
    }()
    
    
    //MARK: Helpers
    
    func getCoreCities() -> [CoreCity] {
        
        //fetch request
        let fetchRequest = NSFetchRequest<CoreCity>(entityName: Constants.Keys.CoreCity.rawValue)
        
        //container
        var coreCities = [CoreCity]()
        
        do {
            
            coreCities = try context.fetch(fetchRequest)
            print("CoreCity Count: \(coreCities.count)")
            return coreCities
            
        } catch {
            
            return []
        }
    }
    
    //MARK: Delete
    func delete(with city: CoreCity) {
        
        context.delete(city)
        
        print("Deleted From Core: \(city.name!)")
        
        saveContext()
        
    }
    
    
     //MARK: Save
    
    func save(with city: City) {
        
        //entity description
        let entity = NSEntityDescription.entity(forEntityName: Constants.Keys.CoreCity.rawValue, in: context)!
        
        //core entity
        let coreCity = NSManagedObject(entity: entity, insertInto: context)
        
        coreCity.setValue(city.name, forKey: Constants.Core.name.rawValue)
        coreCity.setValue(city.state, forKey: Constants.Core.state.rawValue)
        coreCity.setValue(city.population, forKey: Constants.Core.population.rawValue)
        coreCity.setValue(city.coordinates.latitude, forKey: Constants.Core.latitude.rawValue)
        coreCity.setValue(city.coordinates.longitude, forKey: Constants.Core.longitude.rawValue)
        coreCity.setValue(city.rank, forKey: Constants.Core.rank.rawValue)
        
        //save context
        saveContext()
        print("Saved City To Core: \(city.name), \(city.state)")
    }
    
    
    func saveContext() {
        
        do {
           try context.save()
        } catch {
            fatalError("Couldn't save the context")
        }
        
    }
    
}
