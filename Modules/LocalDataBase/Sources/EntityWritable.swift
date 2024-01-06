//
//  EntityWritable.swift
//  GongGanGam-CoreData
//
//  Created by ByeongJu Yu on 2023/01/16.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import CoreData

/// DTO를 CoreData Entity로 변환하여 저장하기 위해 채택해야하는 프로토콜입니다.
public protocol EntityWritable {

    // MARK: - Methods    
    func write(at context: NSManagedObjectContext) throws
}
