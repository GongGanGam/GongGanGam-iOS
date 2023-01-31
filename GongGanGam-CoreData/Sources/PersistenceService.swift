//
//  PersistenceService.swift
//  GongGanGam-CoreData
//
//  Created by ByeongJu Yu on 2023/01/12.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import CoreData

public class PersistenceService {
    
    // MARK: - Properties
    public static let shared: PersistenceService = PersistenceService()
        
    var persistentContainer: NSPersistentContainer?
    
    var context: NSManagedObjectContext {
        get throws {
            guard let persistentContainer else { throw PersistenceError.persistentContainerNotExist }
            return persistentContainer.viewContext
        }
    }
    
    public func updatePersistentContainer(name: String) {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
    
    // MARK: - Methods
    public func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        let fetchResult = try context.fetch(request)
        return fetchResult
    }
    
    @discardableResult
    public func insert<T: EntityWritable>(entity: T) throws -> T {
        
        try entity.write(at: self.context)
        try self.context.save()
        return entity
    }
    
    public func update<T: EntityUpdatable>(entity: T) throws {
        try entity.update(at: self.context)
        try self.context.save()
    }
    
    public func delete<T: NSManagedObject>(id: Int64, type: T.Type) throws {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        
        guard let object = try self.context.fetch(request).first else { throw PersistenceError.invalidEntityId }
        
        try self.context.delete(object)
        try self.context.save()
    }
}
