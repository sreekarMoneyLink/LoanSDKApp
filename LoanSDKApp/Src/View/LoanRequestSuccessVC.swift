//
//  LoanRequestSuccessVC.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class LoanRequestSuccessVC: LendingBaseVC {

    @IBOutlet weak var status: BCUILabel!
    @IBOutlet weak var statusImgView: BCUIImageView!
    @IBOutlet weak var approvalAmount: BCUILabel!
    @IBOutlet weak var bankNameLabel: BCUILabel!
    @IBOutlet weak var bankNameImg: BCUIImageView!
    @IBOutlet weak var bankNameImgIcon: BCUIImageView!
    @IBOutlet weak var bankNameWithAccountNumberLbl: BCUILabel!
    @IBOutlet weak var loanLbl: UILabel!
    
    
    var viewModel:LoanApprovalVM = LoanApprovalVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar(setBgColor: true)
        self.setupStatusBarBackground(bgColor: UIColor.black)
        self.setupUI()
    }
    
    func setupUI() {
        self.status.text = viewModel.loanData?.approvalStatus == true ? "Successful" : "Not Approval"
        self.statusImgView.image = UIImage(named: viewModel.loanData?.approvalStatus == true ? "Success" : "failureIcon")
        self.approvalAmount.text = "₦ \(viewModel.loanData?.eligibleAmount ?? "0.0")"
        self.bankNameLabel.text = viewModel.loanData?.bankName
        self.bankNameImg.downloadImage(from: viewModel.loanData?.bankIcon ?? "")
        self.bankNameImgIcon.downloadImage(from: viewModel.loanData?.bankIcon ?? "")
        self.bankNameWithAccountNumberLbl.text = "\(viewModel.loanData?.bankName ?? "") \n \(viewModel.loanData?.bankAccountNumber ?? "")"
    }
    

    @IBAction func onTapDoneBtn() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
