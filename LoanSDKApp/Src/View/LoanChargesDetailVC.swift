//
//  LoanChargesDetailVC.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class LoanChargesDetailVC: LendingBaseVC {

    @IBOutlet weak var loanAmountTextField: BCUITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var agreebtn: CheckBox!
    @IBOutlet weak var eligibilityLabel: BCUILabel!
    
    @IBOutlet weak var loanTenureLbl: UILabel!
    @IBOutlet weak var bankFeeLbl: UILabel!
    @IBOutlet weak var paylinkLbl: UILabel!
    @IBOutlet weak var creditLbl: UILabel!
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var lateFeeLbl: UILabel!
    @IBOutlet weak var bankNameLbl: BCUILabel!
    @IBOutlet weak var bankLogoImg: BCUIImageView!
    
    var loanApprovalVM:LoanApprovalVM = LoanApprovalVM()
    var viewModel:BankLoanListVM = BankLoanListVM()
    var applyResponseData:LoanData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loanAmountTextField.inputAccessoryView = self.createDoneToolbar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(setBgColor: true)
        self.setupStatusBarBackground(bgColor: UIColor.black)
        self.setup()
        self.setupLoanApprovalBindingData()
    }
    func setup() {
        self.loanAmountTextField.text = ""
        let doubleValue = Double(applyResponseData?.eligibleAmount ?? "")
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
        
        self.bankLogoImg.downloadImage(from: self.viewModel.loanResponse?[0].bankIcon ?? "")
        self.bankNameLbl.text = self.viewModel.loanResponse?[0].bankName
        self.loanTenureLbl.text = "Upto \(applyResponseData?.loantenor ?? "") Days"
        self.bankFeeLbl.text = "\(self.removeTrailingZero(from: applyResponseData?.fee ?? ""))%"
        self.paylinkLbl.text = "\(self.removeTrailingZero(from: applyResponseData?.tenure ?? ""))%"
        self.creditLbl.text = "\(self.removeTrailingZero(from: applyResponseData?.creditLifeInsurance ?? ""))%"
        self.interest.text = "\(self.removeTrailingZero(from: applyResponseData?.interest ?? ""))%"
        self.lateFeeLbl.text = "\(self.removeTrailingZero(from: applyResponseData?.latefee ?? ""))%"
    }
    
    
    private func setupLoanApprovalBindingData() {
            // Handle success
        self.loanApprovalVM.onSuccess = { [weak self] successData in
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LendingAppPinVC") as? LendingAppPinVC {
                        vc.viewModel.loanData = successData
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }

            // Handle failure
        self.loanApprovalVM.onFailure = { [weak self] failureMessage in
                DispatchQueue.main.async {
                    self?.showFailure(failureMessage)
                }
            }

            // Handle error
        self.loanApprovalVM.onError = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showError(errorMessage)
                }
            }
        }
    
    @IBAction func onTappedAgreeBtn(_ sender: CheckBox) {
        agreebtn.isSelected = true
        agreebtn.updateSelectedState()
    }
    
    @IBAction func onTappedSubmitBtn() {
        if agreebtn.isSelected && validateNonEmpty(textField: self.loanAmountTextField) {
            if let amountValue = self.loanAmountTextField.text, let custID = UserSessionManager.shared.custId, let tenantID = UserSessionManager.shared.tenantId {
                let inputAmount = amountValue.replacingOccurrences(of: "₦", with: "").trimmingCharacters(in: .whitespaces)
                self.loanApprovalVM.loanApproval(custId: custID, tenantId: tenantID, typeOfLoan: self.loanApprovalVM.loanType, amount: inputAmount)
            }
        }
        else {
            self.displayErrorAlert(message: "Please accept terms and conditions.")
        }

    }


}

extension LoanChargesDetailVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Get the current text in the text field
            let currentText = textField.text ?? ""
            // Calculate the new text after the user's input
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            // Remove the currency symbol (₦) and whitespace
            let inputAmountString = updatedText.replacingOccurrences(of: "₦", with: "").trimmingCharacters(in: .whitespaces)
            // Convert to a Double for comparison
            let inputAmount = Double(inputAmountString) ?? 0.0
            // Get the eligible amount from your data
            let eligibleAmount = Double(applyResponseData?.eligibleAmount ?? "0.0") ?? 0.0
        
            if inputAmountString == "0" || (currentText.isEmpty && string == "0") {
                return false
            }
        
            if inputAmount > eligibleAmount {
                return false
            }
            
            // Allow the change if it's within the limit
            return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
}

