//
//  PersistenceError.swift
//  GongGanGam-CoreData
//
//  Created by ByeongJu Yu on 2023/01/16.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public enum PersistenceError: LocalizedError {
    case persistentContainerNotExist
    case invalidEntityId
    case unknown
}
