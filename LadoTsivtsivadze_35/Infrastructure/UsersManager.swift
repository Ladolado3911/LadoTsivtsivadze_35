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
    func login(usingPassword pass: String, usingUsername username: String, completion: @escaping (Bool) -> Void)
    
    init(with persistent: PersistentManagerProtocol)
}

final class UsersManager: UsersManagerProtocol {
    
    private var persistent: PersistentManagerProtocol!
    
    var userObject: NSManagedObject? {
        guard let context = context else { return nil }
        guard let description = NSEntityDescription.entity(forEntityName: "User", in: context) else { return nil }
        let obj = NSManagedObject(entity: description, insertInto: context)
        return obj
    }
    
    var users: [User]? {
        guard let userObject = userObject else { return nil }
        guard let entities = getUsers(managedObject: userObject) else { return nil }
        return entities
    }
    
    var loggedInUsers: [User]? {
        return users!.filter { $0.isLoggedin == true }
    }
    
    var loggedInUser: User? {
        guard let userObject = userObject else { return nil }
        guard let entities = getUsers(managedObject: userObject) else { return nil }
        let loggedInUser = entities.filter { $0.isLoggedin }
        if loggedInUser.count != 1 {
            return nil
        }
        else {
            return loggedInUser[0]
        }
    }
    
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
    
    func getUsers(managedObject obj: NSManagedObject) -> [User]? {
        guard let context = context else { return nil }
        guard let name = obj.entity.name else { return nil }
        let request = NSFetchRequest<NSManagedObject>(entityName: name)
        
        do {
            let entities = try context.fetch(request) as? [User]
            return entities
        }
        catch {
            print(error)
            return nil
        }
    }

    func getUser(byUsername name: String) -> User? {
        guard let users = users else {
            print("first guard returned nil")
            return nil
        }

        let user = users.filter { $0.username == name }
        if user.count != 1 {
            print(user)
            print("filtered returned nil")
            return nil
        }
        else {
            return user[0]
        }
    }
    
    func login(usingPassword pass: String, usingUsername username: String, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return }
        
        let user = User(context: context)
        //let predicate = NSPredicate(format: "%K = %@", "password", pass)
        let testPredicate = NSPredicate(format: "username == '\(username)' && password == '\(pass)'")
        logInUser(inputUsername: username, inputPassword: pass) {
            
        }
        persistent.read(with: user, using: testPredicate, completion: completion)
    }

    func makeUserLoggedIn(bool bl: Bool, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return }
        
        let user = User(context: context)
        let predicate = NSPredicate(format: "")
        
        user.isLoggedin = bl
        
        //persistent.update(with: user, using: <#T##NSPredicate?#>, completion: completion)
    }
    
    func logInUser(inputUsername username: String, inputPassword pass: String, completion: @escaping () -> Void) {
        let user = users!.filter { $0.username == username && $0.password == pass }
        if user.count != 1 {
            print("User does not exist")
        }
        else {
            let user = getUser(byUsername: username)
            user!.isLoggedin = true
            completion()
        }
    }
    
    func logOut() {
        guard let context = context else { return }
        let loggedInUser2 = loggedInUser
        loggedInUser2!.isLoggedin = false
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
}
