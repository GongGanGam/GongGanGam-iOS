//
//  UIFont+Swizzling.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/18.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import GongGanGam_UI

/// Swizzle SystemFont to Pretendard (only regular and bold)
private struct PretendardFontName {
    
    static let regular = "Pretendard-Regular"
    static let bold = "Pretendard-Bold"
}

extension UIFontDescriptor.AttributeName {
    
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    static var isSwizzled = false
    
    @objc class func swizzledSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: PretendardFontName.regular, size: size) ?? .systemFont(ofSize: size)
    }
    
    @objc class func swizzledBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: PretendardFontName.bold, size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    @objc convenience init?(swizzledCoder coder: NSCoder) {
        guard let fontDescriptor = coder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
              let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
            self.init(coder: coder)
            return
        }
        
        let fontName: String
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = PretendardFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = PretendardFontName.bold
        default:
            fontName = PretendardFontName.regular
        }
        
        self.init(name: fontName, size: fontDescriptor.pointSize)
    }
    
    static func swizzleSystemFont() {
        guard self == UIFont.self, !isSwizzled else { return }
        
        isSwizzled = true
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
           let swizzledSystemFontMethod = class_getClassMethod(self, #selector(swizzledSystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, swizzledSystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
           let swizzledBoldSystemFontMethod = class_getClassMethod(self, #selector(swizzledBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, swizzledBoldSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))),
           let swizzledCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(swizzledCoder:))) {
            method_exchangeImplementations(initCoderMethod, swizzledCoderMethod)
        }
    }
}
