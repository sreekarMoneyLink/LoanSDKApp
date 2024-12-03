//
//  BankLoanListVC.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class BankLoanListVC: LendingBaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var viewModel:BankLoanListVM = BankLoanListVM()
    var applyVM:LoanApplyVM = LoanApplyVM()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupApplyLoanBindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(setBgColor: true)
        self.setupStatusBarBackground(bgColor: UIColor.black)
        self.tableViewHeight.constant = 300
    }
    
    
    @IBAction func applyBtnAction(_ sender: BCUIButton) {
        if let amount = viewModel.loanResponse?[0].eligibleAmount, let id = viewModel.loanResponse?[0].id, let custID = UserSessionManager.shared.custId, let tenantID = UserSessionManager.shared.tenantId {
            self.applyVM.applyLoan(custId: custID, tenantId: tenantID, typeOfLoan: viewModel.loanType, Id: id, amount: amount)
        }
        
        
    }
    
    
    private func setupApplyLoanBindingData() {
            // Handle success
        self.applyVM.onSuccess = { [weak self] successData in
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LoanChargesDetailVC") as? LoanChargesDetailVC {
                        vc.applyResponseData = successData
                        vc.loanApprovalVM.loanType = self?.viewModel.loanType ?? ""
                        vc.viewModel.loanResponse = self?.viewModel.loanResponse
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }

            // Handle failure
        self.applyVM.onFailure = { [weak self] failureMessage in
                DispatchQueue.main.async {
                    self?.showFailure(failureMessage)
                }
            }

            // Handle error
        self.applyVM.onError = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.showError(errorMessage)
                }
            }
        }
    
}

extension BankLoanListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel.loanResponse?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == (self.viewModel.loanResponse?.count ?? 0) {
            return 140 //UITableView.automaticDimension
        }
        else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (self.viewModel.loanResponse?.count ?? 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "BankLoanDisclaimerTableViewCell", for: indexPath) as! BankLoanDisclaimerTableViewCell
            cell.separatorInset.left = SCREEN_WIDTH
            cell.selectionStyle = .none
            return cell
        }
        else {
            let model = self.viewModel.loanResponse?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "BankLoanListTableViewCell", for: indexPath) as! BankLoanListTableViewCell
            cell.configureCell(model: model!)
//            cell.vc = self
            cell.selectionStyle = .none
            cell.separatorInset.left = SCREEN_WIDTH
//            if indexPath.row%2 == 0 {
//                cell.contentView.backgroundColor = UIColor.skyBlueColor().withAlphaComponent(0.3)
//            }
//            else {
//                cell.contentView.backgroundColor = UIColor.white
//            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let model = self.viewModel.loanList[indexPath.row]
    }
    
}

