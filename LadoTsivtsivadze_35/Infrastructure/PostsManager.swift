//
//  PostsManager.swift
//  LadoTsivtsivadze_35
//
//  Created by Ladolado3911 on 6/17/21.
//

import Foundation
import UIKit
import CoreData

protocol PostsManagerProtocol: BasePersistentProtocol {
    func getUserPosts(user usr: User) -> [Post]?
    
    init(with persistent: PersistentManagerProtocol)
}

final class PostsManager: PostsManagerProtocol {
    
    private var persistent: PersistentManagerProtocol!
    
    init(with persistent2: PersistentManagerProtocol) {
        persistent = persistent2
    }
    
    func getUserPosts(user usr: User) -> [Post]? {
        let posts = usr.posts!.allObjects as? [Post]
        return posts
    }
}
