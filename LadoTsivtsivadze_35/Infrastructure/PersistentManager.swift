//
//  PersistentManager.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import UIKit
import CoreData

protocol PersistentManagerProtocol: BasePersistentProtocol {
    func create<T: NSManagedObject>(with object: T, completion: @escaping ((Bool) -> Void))
    func read<T: NSManagedObject>(with object: T, using predicate: NSPredicate?, completion: @escaping ((Bool) -> Void))
    func update()
    func delete()
}

final class PersistantManager: PersistentManagerProtocol {
    func create<T>(with object: T, completion: @escaping ((Bool) -> Void)) where T : NSManagedObject {
        guard let context = context else { return }
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func read<T>(with object: T, using predicate: NSPredicate?, completion: @escaping ((Bool) -> Void)) where T : NSManagedObject {
        guard let context = context else { return }
        
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "User")
            request.predicate = predicate
            let result = try context.fetch(request)
            completion(!result.isEmpty)
        }
        catch {
            print(error)
        }
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}
