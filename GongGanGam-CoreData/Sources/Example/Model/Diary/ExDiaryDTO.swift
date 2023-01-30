//
//  ExDiaryDTO.swift
//  GongGanGam
//
//  Created by ByeongJu Yu on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import CoreData

/// Example DTO
public struct ExDiaryDTO: EntityWritable {
    
    let id: Int64
    let date: Date
    let emoji: String
    let content: String
    let imgUrl: String
    let isShared: Bool
    
    public init(
        id: Int64,
        date: Date,
        emoji: String,
        content: String,
        imgUrl: String,
        isShared: Bool
    ) {
        self.id = id
        self.date = date
        self.emoji = emoji
        self.content = content
        self.imgUrl = imgUrl
        self.isShared = isShared
    }
    
    public func write(at context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.entity(forEntityName: "ExDiaryEntity", in: context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: context)
            
            managedObject.setValue(self.id, forKey: "id")
            managedObject.setValue(self.date, forKey: "date")
            managedObject.setValue(self.emoji, forKey: "emoji")
            managedObject.setValue(self.content, forKey: "content")
            managedObject.setValue(self.imgUrl, forKey: "imgUrl")
            managedObject.setValue(self.isShared, forKey: "shareAgreed")
        }
    }
}

extension ExDiaryDTO: EntityUpdatable {
    
    public func update(at context: NSManagedObjectContext) throws {
        let request = NSFetchRequest<ExDiaryEntity>(entityName: String(describing: ExDiaryEntity.self))
        request.predicate = NSPredicate(format: "id = %@", NSNumber(value: self.id))
        guard let object = try context.fetch(request).first else { throw PersistenceError.invalidEntityId }
        
        object.setValue(self.date, forKey: "date")
        object.setValue(self.emoji, forKey: "emoji")
        object.setValue(self.content, forKey: "content")
        object.setValue(self.imgUrl, forKey: "imgUrl")
        object.setValue(self.isShared, forKey: "shareAgreed")
        try context.save()
    }
}
