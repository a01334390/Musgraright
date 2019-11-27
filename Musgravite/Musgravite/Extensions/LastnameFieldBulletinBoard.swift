//
//  NameFieldBulletinBoard.swift
//  Musgravite
//
//  Created by Luis Eduardo Brime Gomez on 11/26/19.
//  Copyright © 2019 Aabo Technologies. All rights reserved.
//
import Foundation
import BLTNBoard

class LastnameFieldBulletinPage: BLTNPageItem {
    @objc public var nameField: UITextField!
    @objc public var surField: UITextField!
    @objc public var textInputHandler: ((BLTNActionItem, String?) -> Void)? = nil
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        nameField = interfaceBuilder.makeTextField(placeholder: "Gutierritos", returnKey: .done, delegate: self)
        
        return [nameField]
    }
    
    override func tearDown() {
        super.tearDown()
        nameField?.delegate = nil
    }
    
    override func actionButtonTapped(sender: UIButton) {
        nameField.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
}

extension LastnameFieldBulletinPage: UITextFieldDelegate {
    @objc open func isInputValid(text: String?) -> Bool {
        if text == nil || text!.isEmpty {
            return false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isInputValid(text: textField.text) {
            textInputHandler?(self, textField.text)
        } else {
            descriptionLabel!.textColor = .red
            descriptionLabel!.text = "Debes ingresar tus datos para continuar"
            textField.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
        
    }
}
