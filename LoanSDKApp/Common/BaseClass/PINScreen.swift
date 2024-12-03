//
//  PINScreen.swift
//  OpenAccountSDK
//
//  Created by consultant5 on 30/09/24.
//

import Foundation
import UIKit

protocol PinInputDelegate:AnyObject{
    func didEnterPin(number:String)
}

@IBDesignable
class CustomPinInput: UIView, UITextFieldDelegate {
    
    private var textFields: [UITextField] = []
    private let numberOfFields = 6
    weak var delegate: PinInputDelegate?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(stackView)
        
        // Create text fields
        for i in 0..<numberOfFields {
            let textField = createTextField()
            textField.textColor = UIColor.darkBlueColor()
            textField.tag = i
            textFields.append(textField)
            stackView.addArrangedSubview(textField)
        }
        
        // Layout constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 5
        textField.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        textField.layer.cornerRadius = 10
        textField.textColor = UIColor.blue
        textField.font = UIFont(name: "Roboto-Bold", size: 15)
        
        // Set constraints for square shape
        textField.widthAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Disable auto-correction and pasting
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = false

        return textField
    }

    // MARK: - UITextFieldDelegate Methods

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
          
          // Check if the user is pressing backspace (delete)
        if string.isEmpty {
              // Clear the current field
              textField.text = ""
              
              // Move to the previous text field if possible
              if textField.tag > 0 {
                  textFields[textField.tag - 1].becomeFirstResponder()
              }
              return false
          }
          
          // Only allow one character (digit) in the field
          if currentText.isEmpty && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
              textField.text = string
              // Automatically move to the next field
              if textField.tag < textFields.count - 1 {
                  textFields[textField.tag + 1].becomeFirstResponder()
              } else {
                  // If the last field is filled, close the keyboard
                  textField.resignFirstResponder()
                  delegate?.didEnterPin(number: getPin()) // Notify delegate
              }
              return false
          }
          
          return false
    }
    
    // Handle the text field input change
     @objc private func textFieldDidChange(_ textField: UITextField) {
         guard let text = textField.text, text.count == 1 else { return }
         if textField.tag < textFields.count - 1 {
             textFields[textField.tag + 1].becomeFirstResponder()
         } else {
             textField.resignFirstResponder()
             delegate?.didEnterPin(number: getPin())
         }
     }
    private func getPin() -> String {
            return textFields.reduce("") { $0 + ($1.text ?? "") }
        }
}
