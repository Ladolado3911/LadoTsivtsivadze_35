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
    
    var postObject: NSManagedObject? {
        guard let context = context else { return nil }
        guard let description = NSEntityDescription.entity(forEntityName: "Post", in: context) else { return nil }
        let obj = NSManagedObject(entity: description, insertInto: context)
        return obj
    }
    
    var posts: [Post]? {
        guard let userObject = postObject else { return nil }
        guard let entities = getPosts(managedObject: userObject) else { return nil }
        return entities
    }
    
    init(with persistent2: PersistentManagerProtocol) {
        persistent = persistent2
    }


    func getPosts(managedObject obj: NSManagedObject) -> [Post]? {
        guard let context = context else { return nil }
        guard let name = obj.entity.name else { return nil }
        let request = NSFetchRequest<NSManagedObject>(entityName: name)
        
        do {
            let entities = try context.fetch(request) as? [Post]
            return entities
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func getUserPosts(user usr: User) -> [Post]? {
        let posts = usr.posts!.allObjects as? [Post]
        return posts
    }

    func newPost(title ttl: String, content cnt: String, image img: Data) -> Post? {
        guard let context = context else { return nil }
        let post = Post(context: context)
        post.title = ttl
        post.content = cnt
        post.picture = img
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        return post
    }
}
