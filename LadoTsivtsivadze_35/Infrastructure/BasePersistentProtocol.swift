//
//  BasePersistentProtocol.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import UIKit
import CoreData

//https://forums.swift.org/t/generic-method-in-class-extension/21359

protocol BasePersistentProtocol: AnyObject {
    var context: NSManagedObjectContext? { get }
}

extension BasePersistentProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}
