//
//  EntityUpdatable.swift
//  GongGanGam
//
//  Created by ByeongJu Yu on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import CoreData

/// DTO를 CoreData Entity로 변환하여 업데이트하기 위해 채택해야하는 프로토콜입니다.
public protocol EntityUpdatable {

    // MARK: - Methods
    func update(at context: NSManagedObjectContext) throws
}
