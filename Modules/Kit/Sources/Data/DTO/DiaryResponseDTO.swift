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
    let date: String
    let emoji: String
    let content: String
    let imgUrl: String?
    let shareAgreed: Bool
    let replyId: Int64?
    
    func toModel() -> Diary {
        return Diary(
            diaryId: self.diaryId,
            date: Date.fromStringOrNow(self.date),
            emoji: self.emoji,
            content: self.content,
            imgUrl: self.imgUrl,
            shareAgreed: self.shareAgreed,
            replyId: self.replyId
        )
    }
}
