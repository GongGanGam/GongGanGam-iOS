//
//  ExDiaryEntity+CoreDataProperties.swift
//  GongGanGam-CoreData
//
//  Created by ByeongJu Yu on 2023/01/16.
//  Copyright © 2023 GongGanGam. All rights reserved.
//
//

import Foundation
import CoreData

extension ExDiaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExDiaryEntity> {
        return NSFetchRequest<ExDiaryEntity>(entityName: "ExDiaryEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var date: Date
    @NSManaged public var emoji: String
    @NSManaged public var content: String
    @NSManaged public var imgUrl: String
    @NSManaged public var shareAgreed: Bool
}

extension ExDiaryEntity : Identifiable {

}
