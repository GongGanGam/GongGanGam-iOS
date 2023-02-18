//
//  Fonts.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/25.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

/**
 The "Pretendard" Font Family.
 
 ```swift
 label.font = Pretendard.title
 ```
 */
public enum Pretendard {
    
    // MARK: - Bold
    public static let h1 = GongGanGamUIFontFamily.Pretendard.bold.font(size: 22)
    public static let titleBold = GongGanGamUIFontFamily.Pretendard.bold.font(size: 17)
    public static let bodyBold = GongGanGamUIFontFamily.Pretendard.bold.font(size: 16)
    public static let caption1Bold = GongGanGamUIFontFamily.Pretendard.bold.font(size: 14)
    public static let caption2Bold = GongGanGamUIFontFamily.Pretendard.bold.font(size: 12)
    public static let button1 = GongGanGamUIFontFamily.Pretendard.bold.font(size: 16)
    
    // MARK: - Regular
    public static let title = GongGanGamUIFontFamily.Pretendard.regular.font(size: 17)
    public static let body = GongGanGamUIFontFamily.Pretendard.regular.font(size: 16)
    public static let caption1 = GongGanGamUIFontFamily.Pretendard.regular.font(size: 14)
    public static let caption2 = GongGanGamUIFontFamily.Pretendard.regular.font(size: 12)
    public static let button2 = GongGanGamUIFontFamily.Pretendard.regular.font(size: 14)
    public static let small = GongGanGamUIFontFamily.Pretendard.regular.font(size: 10)
}

public enum OmniGothic {
    
    // MARK: - 050 (Bold)
    public static let h1050 = GongGanGamUIFontFamily._210OmniGothic._050.font(size: 22)
    public static let h2050 = GongGanGamUIFontFamily._210OmniGothic._050.font(size: 20)
    public static let h3050 = GongGanGamUIFontFamily._210OmniGothic._050.font(size: 17)
    
    // MARK: - 030 (Regular)
    public static let h1030 = GongGanGamUIFontFamily._210OmniGothic._030.font(size: 22)
    public static let h2030 = GongGanGamUIFontFamily._210OmniGothic._030.font(size: 20)
}
