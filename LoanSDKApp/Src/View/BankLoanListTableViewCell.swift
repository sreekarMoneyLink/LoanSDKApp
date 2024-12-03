//
//  BankLoanListTableViewCell.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class BankLoanListTableViewCell: UITableViewCell {

    @IBOutlet weak var bankNameLabel: BCUILabel!
    @IBOutlet weak var eligibilityLabel: BCUILabel!
    @IBOutlet weak var feeLabel: BCUILabel!
    @IBOutlet weak var interestLabel: BCUILabel!
    @IBOutlet weak var tenureLabel: BCUILabel!
    @IBOutlet weak var iconImageView: BCUIImageView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: LoanEligibilityResponse.LoanEligibilityData) {
            self.bankNameLabel.text = model.bankName
            self.interestLabel.text = "\(removeTrailingZero(from: model.interest))%"
            self.feeLabel.text = "\(removeTrailingZero(from: model.fee))%"
            self.tenureLabel.text = "\(removeTrailingZero(from: model.tenure)) month"
            self.iconImageView.downloadImage(from: model.bankIcon )
            let doubleValue = Double(model.eligibleAmount)
            let loanAmount = "₦ \(doubleValue ?? 0.0)"
            let fullText = "Loan Eligibility – ₦ \(doubleValue ?? 0.0)"
            if let customFont = UIFont(name: "Roboto-Bold", size: 13) {
                let range = (fullText as NSString).range(of: loanAmount)
                let attributedText = NSMutableAttributedString(string: fullText)
                // Apply bold and color attributes to the dynamic range
                attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: range)
                attributedText.addAttribute(.font, value: customFont, range: range)
                   self.eligibilityLabel?.attributedText = attributedText
            }

        }
    
    func removeTrailingZero(from numberString: String) -> String {
        if numberString.hasSuffix(".0") {
            return String(numberString.dropLast(2)) // Remove the ".0"
        }
        return numberString
    }

    
}
