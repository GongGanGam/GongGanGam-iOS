//
//  TitledPicker.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

/**
 
 */
open class TitledPickerView: TitledView {
    
    // MARK: - UI
    private lazy var borderedContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = nil
        view.layer.borderColor = defaultBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var pickerTextField: UITextField = {
        let field = UITextField()
        let toolbar = InputToolbar(target: self, action: #selector(doneButtonTapped))
        
        field.font = Pretendard.body
        field.tintColor = .clear
        field.inputView = pickerView
        field.inputAccessoryView = toolbar
        return field
    }()
    
    private lazy var downArrowView: UIImageView = {
        let view = UIImageView(image: GongGanGamUIAsset.arrowDown.image)
        
        return view
    }()
    
    /**
     값을 선택할 수 있는 PickerView입니다.
     */
    public lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    // MARK: - Properties
    
    public var placeholder: String? {
        get {
            return self.pickerTextField.placeholder
        }
        set {
            self.pickerTextField.placeholder = newValue
        }
    }
    
    public var text: String? {
        get {
            return self.pickerTextField.text
        }
        set {
            self.pickerTextField.text = newValue
        }
    }
    
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
        self.rootContainer.flex.addItem(borderedContainer)
            .direction(.row)
            .alignItems(.center)
            .height(48)
            .marginTop(8)
            .paddingHorizontal(16)
            .define { flex in
                flex.addItem(pickerTextField).grow(1)
                flex.addItem(downArrowView).aspectRatio(1).width(24).marginLeft(-32)
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
private extension TitledPickerView {
    
    @objc func doneButtonTapped() {
        self.pickerTextField.endEditing(true)
    }
    
    func startObservingTextFieldEditingStatus() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidBeginEditing),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: self.pickerTextField)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidEndEditing),
                                               name: UITextField.textDidEndEditingNotification,
                                               object: self.pickerTextField)
    }
    
    @objc func textFieldDidBeginEditing() {
        self.borderColor = editingBorderColor
    }
    
    @objc func textFieldDidEndEditing() {
        self.borderColor = defaultBorderColor
    }
    
    func stopObservingTextFieldEditingStatus() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextField.textDidEndEditingNotification,
                                                  object: self.pickerTextField)
    }
}
