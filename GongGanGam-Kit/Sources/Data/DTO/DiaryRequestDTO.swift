//
//  DiaryRequestDTO.swift
//  GongGanGam
//
//  Created by kimchansoo on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

struct DiaryRequestDTO {
    let date: Date
    let emoji: String
    let content: String
    let shareAgreed: Bool
    let image: Data?
}
