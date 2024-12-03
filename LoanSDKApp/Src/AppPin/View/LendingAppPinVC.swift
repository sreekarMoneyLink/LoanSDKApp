//
//  AppPinVC.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import UIKit

class LendingAppPinVC: LendingBaseVC {
    
    @IBOutlet weak var pinView:PINScreenView!
    @IBOutlet weak var OTPTxtView: OTPTextView!
    
     var viewModel: LendingPINVM = LendingPINVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.OTPTxtView.inputCount = 4
        self.pinView.handleInputChange = { [weak self] newValue in
            self?.OTPTxtView.inputValue = newValue
            if newValue.count == 4{
                self?.enterPinAction(pin: newValue)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupVerifyUserBindingData()
        self.setupStatusBarBackground(bgColor: .white)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func enterPinAction(pin:String){
        
        // Verify app PIN (Example API call)
        if let bvn = UserSessionManager.shared.bvn, let tenantId = UserSessionManager.shared.tenantId{
            self.viewModel.verifyAppPin(pin: pin, bvn: bvn, tenantId: tenantId)
        }
        
    }
    
    private func setupVerifyUserBindingData() {
            // Handle success
        self.viewModel.onVerifyUserSuccess = { [weak self] successData in
                DispatchQueue.main.async {
                    if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "LoanRequestSuccessVC") as? LoanRequestSuccessVC {
                        vc.viewModel.loanData = self?.viewModel.loanData
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }

            // Handle failure
        self.viewModel.onVerifyUserFailure = { [weak self] failureMessage in
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
    
    
//    private func screenNavigation(status:Bool){
//        switch status {
//        case true:
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenerateQRCodeVC") as? GenerateQRCodeVC{
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            return
//        case false:
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SoftTokenVC") as? SoftTokenVC{
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//            return
//        }
//    }
}
