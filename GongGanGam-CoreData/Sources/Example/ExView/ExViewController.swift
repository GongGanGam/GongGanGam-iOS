//
//  ExViewController.swift
//  GongGanGam-CoreData
//
//  Created by ByeongJu Yu on 2023/01/12.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

public final class ExViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fetch", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("update", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)

        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        PersistenceService.shared.updatePersistentContainer(name: "ExStore")
        [textField, saveButton, fetchButton, deleteButton,updateButton].forEach{ view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400)
        ])
        
    }
    
    @objc func saveButtonTapped() {
        print("save")
        let id = Int64(self.textField.text ?? "")!
        let diary = ExDiaryDTO(
            id: id,
            date: Date(),
            emoji: "Sad",
            content: "오늘은 코아데이타를 뿌셔보았다. 과연 성공할 수 있을까?",
            imgUrl: "https://www.GonGanGam.com",
            isShared: true
        )
        
        do {
            try PersistenceService.shared.insert(entity: diary)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func fetchButtonTapped() {
        guard let diary = try? PersistenceService.shared.fetch(type: ExDiaryEntity.self) else {
            print("에러")
            return
        }
        print(diary.map { $0.toModel() })
    }
    
    @objc func deleteButtonTapped() {
        let id = Int64(self.textField.text ?? "")!
        do {
            try PersistenceService.shared.delete(id: id, type: ExDiaryEntity.self)
            print("삭제 성공")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateButtonTapped() {
        let id = Int64(self.textField.text ?? "")!
        
        let diary = ExDiaryDTO(
            id: id,
            date: Date(),
            emoji: "happy",
            content: "오늘은 코아데이타를 수정을 해보았다. 과연 성공할 수 있을까?",
            imgUrl: "https://www.GonGanGam.com",
            isShared: true
        )
        do {
            try PersistenceService.shared.update(entity: diary)
            print("업데이트 성공")
        } catch {
            print(error.localizedDescription)
        }
    }
}


