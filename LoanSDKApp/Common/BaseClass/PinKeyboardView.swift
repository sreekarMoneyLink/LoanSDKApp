import UIKit

protocol PinKeyboardViewDelegate: AnyObject {
    func didPressNumber(_ number: Int)
    func didPressBackspace()
}

class PinKeyboardView: UIView {

    weak var delegate: PinKeyboardViewDelegate?
    
    
    
    private let numbers = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [-1, 0, -2] // -1 for spacing, 0 in center, -2 for backspace
    ]
    
    private let spacing: CGFloat = 10  // Space between buttons
    
    var numberValue: String = "" {
           didSet {
               handleInputChange?(numberValue)
           }
       }
    var handleInputChange: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.spacing = spacing
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStack)
        
        // Set vertical stack to center in PinKeyboardView
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // Loop through rows to create horizontal stack views with dynamically sized buttons
        for row in numbers {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .fill
            horizontalStack.distribution = .equalSpacing
            horizontalStack.spacing = spacing
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false
            
            for number in row {
                let button = UIButton(type: .system)
                button.layer.cornerRadius = 8
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.lightGray.cgColor
                button.backgroundColor = UIColor.white
                button.setTitleColor(.black, for: .normal)
                
                if number >= 0 {
                    button.setTitle("\(number)", for: .normal)
                    button.tag = number
                    button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                } else if number == -2 {
                    button.setTitle("⌫", for: .normal)
                    button.addTarget(self, action: #selector(backspacePressed(_:)), for: .touchUpInside)
                } else {
                    button.isHidden = false // Placeholder for spacing
                    button.setTitle(" ", for: .normal)
                    button.layer.cornerRadius = 8
                    button.layer.borderWidth = 0
                    button.backgroundColor = UIColor.white
                }
                
                // Add button to horizontal stack
                horizontalStack.addArrangedSubview(button)
                
                // Ensure button remains square
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
            }
            
            // Add horizontal stack to vertical stack
            verticalStack.addArrangedSubview(horizontalStack)
            
            // Set button size based on available width of PinKeyboardView
            NSLayoutConstraint.activate([
                horizontalStack.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -2 * spacing),
                horizontalStack.arrangedSubviews[0].widthAnchor.constraint(equalTo: horizontalStack.widthAnchor, multiplier: 1/3, constant: -2 * spacing / 3)
            ])
        }
    }
    
    // MARK: - Actions
    @objc private func numberPressed(_ sender: UIButton) {
        guard numberValue.count <= 4 else {
                  return
            }
           let number = sender.tag
           numberValue.append("\(number)")
           delegate?.didPressNumber(number)
       }

       @objc private func backspacePressed(_ sender: UIButton) {
           if !numberValue.isEmpty {
               delegate?.didPressBackspace()
           }
       }
}
