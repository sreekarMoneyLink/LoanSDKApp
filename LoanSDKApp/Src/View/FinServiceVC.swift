//
//  FinServiceVC.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class FinServiceVC: LendingBaseVC {
    
    var viewModel:LoanEligibilityVM = LoanEligibilityVM()
    var loan:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(setBgColor: true)
        self.setupStatusBarBackground(bgColor: UIColor.black)
        self.setupLoaneligibilityBindingData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func tapBtnClickAction(_ sender: UIButton) {
        print("Tapped Button Clicked ",sender.tag)
        if sender.tag == 0 {
            self.callAPI(loanType: "PAYDAYLOAN")
        }else if sender.tag == 1 {
            self.callAPI(loanType: "SalaryAdvance")
        }else if sender.tag == 2 {
            self.callAPI(loanType: "SmallTicketPersonalLoan")
        }else if sender.tag == 3{
            self.callAPI(loanType: "PersonalLoan")
        }else if sender.tag == 4{
            self.callAPI(loanType: "ConsumerDurableLoan")
        }else if sender.tag == 5{
            self.callAPI(loanType: "CarLoan")
        }else if sender.tag == 6{
            self.callAPI(loanType: "HomeLoan")
        }else if sender.tag == 7{
            self.callAPI(loanType: "CreditCard")
        }else if sender.tag == 8{
            self.callAPI(loanType: "ViewLoanStatement")
        }else if sender.tag == 9{
            self.callAPI(loanType: "TrackLoanApplication")
        }else if sender.tag == 10{
            self.callAPI(loanType: "CardLoanRepayments")
        }
        
        
    }
    
    private func callAPI(loanType:String){
        if let custID = UserSessionManager.shared.custId, let tenantID = UserSessionManager.shared.tenantId {
            self.loan = loanType
            self.viewModel.getLoanEligibility(custId: custID, tenantId: tenantID, typeOfLoan: loanType.uppercased())
        }
        
    }
    
    
    private func setupLoaneligibilityBindingData() {
            // Handle success
        self.viewModel.onSuccess = { [weak self] successData in
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "BankLoanListVC") as? BankLoanListVC {
                        vc.viewModel.loanResponse = [successData]
                        vc.viewModel.loanType = self?.loan.uppercased() ?? ""
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }

            // Handle failure
        self.viewModel.onFailure = { [weak self] failureMessage in
                DispatchQueue.main.async {
                    self?.showFailure(failureMessage)
                }
            }

            // Handle error
        self.viewModel.onError = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showError(errorMessage)
                }
            }
        }
    
    private func screenNavigation(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BankLoanListVC") as? BankLoanListVC {
                    self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    
}


