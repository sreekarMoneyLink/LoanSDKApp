//
//  LoanEligibilityVM.swift
//  LendingSDK
//
//  Created by Ravindra on 27/11/24.
//

import Foundation
class LoanEligibilityVM {
    
    private let apiService: APIService
    
    // Closures for data, error handling, and failure responses
    var onSuccess: ((LoanEligibilityResponse.LoanEligibilityData) -> Void)?
    var onFailure: ((String) -> Void)? // For failure cases where success = false
    var onError: ((String) -> Void)? // For API errors (network, decoding, etc.)
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    // Function to fetch Business Category list
    func getLoanEligibility(custId:String,tenantId:String,typeOfLoan:String) {
        let parameters: [String: Any] = [
            "custid": custId,
            "tenantid": tenantId,
            "typeofloan": typeOfLoan
        ]
        apiService.postRequest(endpoint: .loanEligibility, parameters: parameters){ (result: Result<LoanEligibilityResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    // Success case when response.success is true
                    if let subcategories = response.data {
                        self.onSuccess?(subcategories)
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
    
    func removeTrailingZero(from numberString: String) -> String {
        if numberString.hasSuffix(".0") {
            return String(numberString.dropLast(2)) // Remove the ".0"
        }
        return numberString
    }
    
}
