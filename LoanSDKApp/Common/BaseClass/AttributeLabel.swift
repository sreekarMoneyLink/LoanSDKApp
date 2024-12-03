import UIKit

@IBDesignable
class AttributedLabel: UILabel {

    // Properties to hold the attributed string
    @IBInspectable var attributedTextString: String? {
        didSet {
            updateAttributedText()
        }
    }
    
    // Font size properties
    @IBInspectable var firstPartFontSize: CGFloat = 24 {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var secondPartFontSize: CGFloat = 18 {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var thirdPartFontSize: CGFloat = 16 {
        didSet {
            updateAttributedText()
        }
    }
    
    // Font type properties (0 = Regular, 1 = Bold)
    @IBInspectable var firstPartFontType: Int = 0 {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var secondPartFontType: Int = 0 {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var thirdPartFontType: Int = 0 {
        didSet {
            updateAttributedText()
        }
    }

    // Text properties for each part
    @IBInspectable var firstPartText: String? {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var secondPartText: String? {
        didSet {
            updateAttributedText()
        }
    }
    
    @IBInspectable var thirdPartText: String? {
        didSet {
            updateAttributedText()
        }
    }

    private func updateAttributedText() {
        guard let firstPart = firstPartText,
              let secondPart = secondPartText,
              let thirdPart = thirdPartText else {
            return
        }

        let fullString = "\(firstPart) \(secondPart) \(thirdPart)"
        let attributedString = NSMutableAttributedString(string: fullString)
        
        // Apply attributes for the first part
        let firstRange = (fullString as NSString).range(of: firstPart)
        let firstFont = firstPartFontType == 1 ? UIFont.boldSystemFont(ofSize: firstPartFontSize) : UIFont.systemFont(ofSize: firstPartFontSize)
        attributedString.addAttribute(.font, value: firstFont, range: firstRange)
        
        // Apply attributes for the second part
        let secondRange = (fullString as NSString).range(of: secondPart)
        let secondFont = secondPartFontType == 1 ? UIFont.boldSystemFont(ofSize: secondPartFontSize) : UIFont.systemFont(ofSize: secondPartFontSize)
        attributedString.addAttribute(.font, value: secondFont, range: secondRange)
        
        // Apply attributes for the third part
        let thirdRange = (fullString as NSString).range(of: thirdPart)
        let thirdFont = thirdPartFontType == 1 ? UIFont.boldSystemFont(ofSize: thirdPartFontSize) : UIFont.systemFont(ofSize: thirdPartFontSize)
        attributedString.addAttribute(.font, value: thirdFont, range: thirdRange)

        self.attributedText = attributedString
    }
}
