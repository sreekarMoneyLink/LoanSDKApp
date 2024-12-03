//
//  PINScreen.swift
//  InstaCard
//
//  Created by Ravindra on 17/10/24.
//

import Foundation

import UIKit

class PINScreenView: UIView {

    // Properties
    var numberValue: String = "" {
        didSet {
            handleInputChange?(numberValue)
        }
    }
    var handleInputChange: ((String) -> Void)?
    private var activeItem: String?

    private let buttonSize: CGFloat = 40     //UIScreen.main.bounds.width / 5.5
    private let rows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["10", "0", "clear"]
    ]

    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNumberPad()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNumberPad()
    }

    // Create the number pad layout
    private func setupNumberPad() {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.distribution = .fillEqually
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        for row in rows {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 10
            horizontalStack.distribution = .fillEqually
            
            for item in row {
                let button = createButton(with: item)
                button.tag = item == "clear" ? -1 : (Int(item) ?? 0)
                if item != "10" {
                    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
                horizontalStack.addArrangedSubview(button)
                print("button.tag ==",button.tag)
            }
            
            verticalStack.addArrangedSubview(horizontalStack)
        }
        
        addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])
    }

    // Create the buttons for the number pad
    private func createButton(with title: String) -> UIButton {
        print("buttonSize",buttonSize)
        let button = UIButton(type: .system)
        button.setTitle(title != "10" ? title : "", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.layer.borderWidth = title != "10" ? title == "clear" ? 0 : 1.5 : 0
        button.layer.borderColor = title != "10" ? title == "clear" ? UIColor.white.cgColor : UIColor.lightGray.cgColor : UIColor.white.cgColor
        button.layer.cornerRadius = title != "10" ? title == "clear" ? 0 : 8 : 0
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        if title != "clear" {
            button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        }else{
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        
        
        if title == "clear" {
            button.setTitle("", for: .normal)
            button.setImage(UIImage(named: "number-pad cancel icon"), for: .normal)
            button.tintColor = UIColor.darkGray
        }
        
        return button
    }

    // Handle button press
    @objc private func buttonTapped(_ sender: UIButton) {
        if numberValue.count < 4{
            if sender.tag == -1 {
                numberValue = String(numberValue.dropLast())
            } else {
                numberValue += "\(sender.tag)"
            }
        }else if numberValue.count == 4 {
            if sender.tag == -1 {
                numberValue = String(numberValue.dropLast())
            } 
        }
        
    }
}


