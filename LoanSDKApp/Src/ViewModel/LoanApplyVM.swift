//
//  LoanApplyVM.swift
//  LendingSDK
//
//  Created by Rex on 27/11/24.
//

import Foundation

class LoanApplyVM {
    
    private let apiService: APIService
    
    // Closures for data, error handling, and failure responses
    var onSuccess: ((LoanData) -> Void)?
    var onFailure: ((String) -> Void)? // For failure cases where success = false
    var onError: ((String) -> Void)? // For API errors (network, decoding, etc.)
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    // Function to fetch Business Category list
    func applyLoan(custId:String,tenantId:String,typeOfLoan:String,Id:String,amount:String) {
        let parameters: [String: Any] = [
            "custid": custId,
            "tenantid": tenantId,
            "typeofloan": typeOfLoan,
            "id": Id,
            "amount": amount
        ]
        apiService.postRequest(endpoint: .applyLoan, parameters: parameters){ (result: Result<LoanResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    // Success case when response.success is true
                    if let applyloan = response.data {
                        self.onSuccess?(applyloan)
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
