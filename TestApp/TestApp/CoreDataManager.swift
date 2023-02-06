//
//  CoreDataManager.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 03.02.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TestApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD functions -
    
    func create<T: NSManagedObject>(entityType: T.Type) -> T {
        let managedObjectContext = persistentContainer.viewContext
        return NSEntityDescription.insertNewObject(forEntityName: entityType.entity().name!, into: managedObjectContext) as! T
    }

    func read<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let managedObjectContext = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<T>(entityName: entityType.entity().name!)
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sortDescriptors
            do {
                let results = try managedObjectContext.fetch(fetchRequest)
                return results
            } catch {
                print("Error fetching data from Core Data")
                return []
            }
        }

    func update<T: NSManagedObject>(object: T) {
        saveContext()
    }

    func delete<T: NSManagedObject>(object: T) {
        let managedObjectContext = persistentContainer.viewContext
        managedObjectContext.delete(object)
        do {
            try managedObjectContext.save()
        } catch {
            print("Error deleting object from Core Data")
        }
    }
}
