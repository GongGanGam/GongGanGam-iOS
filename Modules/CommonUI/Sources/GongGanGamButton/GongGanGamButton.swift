//
//  GongGanGamButton.swift
//  GongGanGam-UI
//
//  Created by dio.zip on 1/4/24.
//  Copyright © 2024 GongGanGam. All rights reserved.
//

import SwiftUI

struct GongGanGamButton: View {
    @Environment(\.isEnabled) var isEnabled
    
    private var originStyle: Style
    
    init(originStyle: Style) {
        self.originStyle = originStyle
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("gg")
            
            Spacer()
        }
    
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

extension GongGanGamButton {
    public enum Style {
        case lightBackground
        case darkBackground
        case disabled
        
        var textColor: Color {
            switch self {
            case .lightBackground:
                return Gong
            }
        }
    }
}
//
//#Preview {
//    GongGanGamButton()
//}
