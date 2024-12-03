//
//  OTPTextView.swift
//  InstaCard
//
//  Created by Ravindra on 17/10/24.
//

import Foundation
import UIKit

class OTPTextView: UIView {
    
    // Properties
    var inputCount: Int {
            didSet {
                setupLabels() // Call setupLabels when inputCount changes
            }
        }
      var inputValue: String = "" {
          didSet {
              handleInputChange?(inputValue)
              updateLabels()
          }
      }
      var handleInputChange: ((String) -> Void)?
      var darkBlueColor: UIColor = UIColor(red: 38/255, green: 154/255, blue: 105/255, alpha: 1)
      private var labels: [UILabel] = []
      
      // StackView for layout
      private let stackView: UIStackView = {
          let stackView = UIStackView()
          stackView.axis = .horizontal
          stackView.spacing = 10
          stackView.distribution = .fillEqually
          return stackView
      }()
      
      // Initialization
        init(inputCount: Int) {
            self.inputCount = inputCount
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            self.inputCount = 4
            super.init(coder: coder)
            setupView()
        }
      
      private func setupView() {
          addSubview(stackView)
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              stackView.topAnchor.constraint(equalTo: topAnchor),
              stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
              stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
              stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
          ])
          
          self.setupLabels()
      }
    
    private func setupLabels() {
            // Remove existing labels
            labels.forEach { $0.removeFromSuperview() }
            labels.removeAll()
            
            for _ in 0..<inputCount {
                let label = createLabel()
                stackView.addArrangedSubview(label)
                labels.append(label)
            }
        }
    
    // Create a label
       private func createLabel() -> UILabel {
           let label = UILabel()
           label.textAlignment = .center
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.layer.borderWidth = 2
           label.layer.borderColor = UIColor.lightGray.cgColor
           label.layer.cornerRadius = 8
           label.backgroundColor = .white
           label.clipsToBounds = true
           return label
       }
       
       // Update labels based on input value
       private func updateLabels() {
           for (index, label) in labels.enumerated() {
               if index < inputValue.count {
                   label.backgroundColor = UIColor.fromHexCode(hex: "#263669")
                   label.layer.borderColor = UIColor.fromHexCode(hex: "#263669").cgColor
               } else {
                   label.text = ""
                   label.backgroundColor = .white 
                   label.layer.borderColor = UIColor.lightGray.cgColor
               }
           }
       }
}
