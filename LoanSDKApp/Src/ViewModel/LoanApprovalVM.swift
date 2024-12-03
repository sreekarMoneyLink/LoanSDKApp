//
//  LoanApprovalVM.swift
//  LendingSDK
//
//  Created by Rex on 27/11/24.
//

import Foundation
class LoanApprovalVM {
    
    private let apiService: APIService
    
    // Closures for data, error handling, and failure responses
    var onSuccess: ((LoanDetails) -> Void)?
    var onFailure: ((String) -> Void)? // For failure cases where success = false
    var onError: ((String) -> Void)? // For API errors (network, decoding, etc.)
    var loanData:LoanDetails?
    var loanType:String = ""
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    // Function to fetch Business Category list
    func loanApproval(custId:String,tenantId:String,typeOfLoan:String,amount:String) {
        let parameters: [String: Any] = [
            "custid": custId,
            "tenantid": tenantId,
            "typeofloan": typeOfLoan,
            "amount": amount
        ]
        apiService.postRequest(endpoint: .submitLoan, parameters: parameters){ (result: Result<LoanSubmissionResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    // Success case when response.success is true
                    if let submit = response.data {
                        self.onSuccess?(submit)
                    } else {
                        // Handle empty  case
                        self.onFailure?("loan not eligible Found.")
                    }
                } else {
                    // Failure case when response.success is false
                    self.onFailure?(response.message)
                }
            case .failure(let error):
                // Handle other API errors (network, decoding, etc.)
                self.onError?(error.localizedDescription)
            }
        }
    }
    
}
