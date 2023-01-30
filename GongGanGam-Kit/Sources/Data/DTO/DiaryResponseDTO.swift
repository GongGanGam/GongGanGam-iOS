//
//  DiaryResponseDTO.swift
//  GongGanGam
//
//  Created by kimchansoo on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

struct DiaryResponseDTO: Decodable {
    
    let diaryId: Int64?
    let date: Int
    let emoji: String
    let content: String
    let imgUrl: String?
    let shareAgreed: Bool
}
