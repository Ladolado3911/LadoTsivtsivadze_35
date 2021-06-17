//
//  UsersManager.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import UIKit
import CoreData

protocol UsersManagerProtocol: BasePersistentProtocol {
    func register(usingPassword pass: String, completion: @escaping () -> Void)
    func login(usingPassword pass: String, completion: @escaping () -> Void)
    
    init(with persistent: PersistentManagerProtocol)
}

final class UsersManager: UsersManagerProtocol {
    
    private var persistent: PersistentManagerProtocol!
    
    init(with persistent2: PersistentManagerProtocol) {
        persistent = persistent2
    }
    
    func register(usingPassword pass: String, completion: @escaping () -> Void) {
        //persistent.create(with: <#T##T#>, completion: <#T##((Bool) -> Void)##((Bool) -> Void)##(Bool) -> Void#>)
    }
    
    func login(usingPassword pass: String, completion: @escaping () -> Void) {
        
    }
}
