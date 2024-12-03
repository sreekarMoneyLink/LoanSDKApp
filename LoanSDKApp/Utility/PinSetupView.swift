import UIKit

protocol PinSetupDelegate: AnyObject {
    func didEnterPin(number: String, for pinView: PinSetupView)
}

class PinSetupView: UIView, UITextFieldDelegate {
    
    private var textFields: [UITextField] = []
    private let numberOfFields = 4
    weak var delegate: PinSetupDelegate?
    
    // Eye icon image view
    private let eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "view-off") // Load the image as-is
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Transparent button on top of the eye image
    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
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
        self.backgroundColor = UIColor.clear
        addSubview(stackView)
        addSubview(eyeImageView)
        addSubview(eyeButton)
        
        // Create text fields and add them to the stackView
        for i in 0..<numberOfFields {
            let textField = createTextField()
            textField.tag = i
            textFields.append(textField)
            stackView.addArrangedSubview(textField)
            
            // Set square dimensions after adding to stack view
            textField.widthAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
        }
        
        // Layout constraints for stackView, eyeImageView, and eyeButton
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: eyeImageView.leadingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            eyeImageView.widthAnchor.constraint(equalToConstant: 24),
            eyeImageView.heightAnchor.constraint(equalToConstant: 24),
            eyeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            eyeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Overlay eyeButton on eyeImageView
            eyeButton.leadingAnchor.constraint(equalTo: eyeImageView.leadingAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: eyeImageView.trailingAnchor),
            eyeButton.topAnchor.constraint(equalTo: eyeImageView.topAnchor),
            eyeButton.bottomAnchor.constraint(equalTo: eyeImageView.bottomAnchor)
        ])
        
        // Set up the eye button action
        eyeButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.inputTextFieldBorderColor().cgColor
        textField.layer.cornerRadius = 8
        textField.inputAccessoryView = createDoneToolbar()
        textField.textColor = UIColor.black
        textField.font = UIFont(name: "Roboto-Bold", size: 19)
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        
        return textField
    }
    
    func createDoneToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Create a flexible space and a "Done" button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }
    
    @objc func doneButtonTapped() {
        self.endEditing(true)  // Dismiss the keyboard
    }
    
    // MARK: - Toggle Pin Visibility

    @objc private func toggleVisibility() {
        // Toggle between secure and non-secure text entry
        let isSecure = textFields.first?.isSecureTextEntry ?? true
        textFields.forEach { $0.isSecureTextEntry = !isSecure }
        
        // Update the image based on the current state
        let imageName = isSecure ? "view" : "view-off"
        eyeImageView.image = UIImage(named: imageName)
    }
    
    // MARK: - UITextFieldDelegate Methods

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        if string.isEmpty { // Handle backspace (delete)
            textField.text = ""
            if textField.tag > 0 {
                textFields[textField.tag - 1].becomeFirstResponder()
            }
            return false
        }
        
        // Only allow a single digit input
        if currentText.isEmpty && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) {
            textField.text = string
            if textField.tag < textFields.count - 1 {
                textFields[textField.tag + 1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                delegate?.didEnterPin(number: getPin(), for: self) // Notify delegate when complete
            }
            return false
        }
        
        return false // Don't allow more than 1 character
    }
    
    // Get the entered PIN by concatenating the text of all fields
    private func getPin() -> String {
        return textFields.reduce("") { $0 + ($1.text ?? "") }
    }
}
