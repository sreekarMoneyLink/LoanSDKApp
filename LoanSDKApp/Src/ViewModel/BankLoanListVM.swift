//
//  BankLoanListVM.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import Foundation
class BankLoanListVM: NSObject{
    var loanList = [EligibleLoan]()
    var loanResponse:[LoanEligibilityResponse.LoanEligibilityData]?
    var loanType:String = ""
      
      override init() {
          let dict: [String:Any] = ["id":0, "bankName": "Access Bank", "bankIcon": "AccessBank", "eligibleAmount": 300000, "interest": 3, "tenure": 5, "fee": 3]
                        if let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                            do {
                                let loan = try JSONDecoder().decode(EligibleLoan.self, from: data)
                                self.loanList.append(loan)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                    }
      }
}
