//
//  TitledTextField.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

/**
 제목을 가지는 TextField입니다. `TitledView`를 상속받습니다.
 ```
 | [Title]         |
 | [  TextField  ] |
 ```
 
 `TitledTextField`는 테두리를 나타내는 `borderedContainer`와 그 안에 포함된 `textField` 프로퍼티를 가지고 있습니다.
 
 RxSwift의 사용을 고려해 Delegate 대신 Notification으로 텍스트의 변경을 감지하였습니다.
 
 TextField가 작성 중이지 않을 때의 테두리 색상을 나타냅니다.
 
 ```swift
 var defaultBorderColor: CGColor
 ```
 - TextField가 활성화되지 않은 상태(not editing)일 때의 테두리 색상입니다. 기본으로 Neutral70을 가집니다.
 
 ```swift
 var editingBorderColor: CGColor
 ```
 - TextField가 활성화되었을 때(while editing)일 때의 테두리 색상입니다. 기본으로 Neutral10을 가집니다.
 */
open class TitledTextField: TitledView {
    
    // MARK: - UI
    private lazy var borderedContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = nil
        view.layer.borderColor = GongGanGamUIAsset.neutral70.color.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    public lazy var textField: UITextField = {
        let field = UITextField()
        
        field.font = Pretendard.body
        field.tintColor = GongGanGamUIAsset.neutral10.color
        return field
    }()
    
    // MARK: - Properties
    
    /// TextField가 활성화되지 않은 상태(not editing)일 때의 테두리 색상입니다. 기본으로 Neutral70을 가집니다.
    public var defaultBorderColor: CGColor = GongGanGamUIAsset.neutral70.color.cgColor
    
    /// TextField가 활성화되었을 때(while editing)일 때의 테두리 색상입니다. 기본으로 Neutral10을 가집니다.
    public var editingBorderColor: CGColor = GongGanGamUIAsset.neutral10.color.cgColor
    
    /// `TitledTextField`의 테두리 색상입니다.
    public var borderColor: CGColor? {
        get {
            return borderedContainer.layer.borderColor
        }
        set {
            borderedContainer.layer.borderColor = newValue
        }
    }
    
    // MARK: - Initializers
    public override init() {
        super.init()
        
        startObservingTextFieldEditingStatus()
        self.rootContainer.flex.addItem(borderedContainer).marginTop(8).define { flex in
            flex.addItem(textField).marginHorizontal(18).height(48)
        }
    }
    
    deinit {
        stopObservingTextFieldEditingStatus()
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.rootContainer.pin.all()
        self.rootContainer.flex.layout()
    }
}

// MARK: - Privates
private extension TitledTextField {
    
    func startObservingTextFieldEditingStatus() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidBeginEditing),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: nil)
    }
    
    @objc func textFieldDidBeginEditing() {
        self.borderColor = editingBorderColor
    }
    
    @objc func textFieldDidEndEditing() {
        self.borderColor = defaultBorderColor
    }
    
    func stopObservingTextFieldEditingStatus() {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidEndEditingNotification, object: nil)
    }
}
