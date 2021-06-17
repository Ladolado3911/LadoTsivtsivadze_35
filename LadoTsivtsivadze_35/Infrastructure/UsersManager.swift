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
    func register(usingPassword pass: String, usingUsername username: String, completion: @escaping (Bool) -> Void)
    func login(usingPassword pass: String, completion: @escaping (Bool) -> Void)
    
    init(with persistent: PersistentManagerProtocol)
}

final class UsersManager: UsersManagerProtocol {
    
    private var persistent: PersistentManagerProtocol!
    
    init(with persistent2: PersistentManagerProtocol) {
        persistent = persistent2
    }
    
    func register(usingPassword pass: String, usingUsername username: String, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return }
        
        let user = User(context: context)
        user.username = username
        user.password = pass
        persistent.create(with: user, completion: completion)
    }
    
    func login(usingPassword pass: String, completion: @escaping (Bool) -> Void) {
        
    }
}
