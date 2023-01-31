//
//  DiaryEntity+CoreDataProperties.swift
//  GongGanGam-Kit
//
//  Created by ByeongJu Yu on 2023/01/31.
//  Copyright © 2023 GongGanGam. All rights reserved.
//
//

import Foundation
import CoreData


extension DiaryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryEntity> {
        return NSFetchRequest<DiaryEntity>(entityName: "DiaryEntity")
    }

    @NSManaged public var content: String
    @NSManaged public var date: Date
    @NSManaged public var emoji: String
    @NSManaged public var id: Int64
    @NSManaged public var imgUrl: String
    @NSManaged public var shareAgreed: Bool

}

extension DiaryEntity : Identifiable {

}
