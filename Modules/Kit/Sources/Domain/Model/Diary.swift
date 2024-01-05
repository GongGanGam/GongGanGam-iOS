//
//  Diary.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/02/01.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

// 현재 내 일기에서 답장에 대한 정보를 여기서 들고 있어야 할까?
public struct Diary {
    
    var diaryId: Int64?
    let date: Date
    var emoji: String
    var content: String
    var imgUrl: String?
    let shareAgreed: Bool
    // 있어야겠지?
    var replyId: Int64?
    
//    init(date: Date, emoji: String, content: String, shareAgreed: Bool) {
//        self.date = date
//        self.emoji = emoji
//        self.content = content
//        self.shareAgreed = shareAgreed
//    }
}
