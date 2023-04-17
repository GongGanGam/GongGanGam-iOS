//
//  BaseURL.swift
//  GongGanGam-Kit
//
//  Created by 김세영 on 2023/02/20.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

internal extension URL {
    
    var baseURL: URL? {
        return URL(string: "http://18.189.150.89:8080/api/")
    }
}
