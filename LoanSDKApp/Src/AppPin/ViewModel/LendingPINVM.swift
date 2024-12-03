//
//  VerifyPINVM.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import Foundation

class LendingPINVM {
    private let apiService: APIService
    
    // Closures for handling the response
    var onVerifyUserSuccess: ((LendingVerifyPinResponse) -> Void)?
    var onVerifyUserFailure: ((String) -> Void)?
    var onError: ((String) -> Void)?
    var loanData:LoanDetails?
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    // Function to verify app pin
    func verifyAppPin(pin: String, bvn: String, tenantId: String) {
        let parameters: [String: Any] = [
            "pin": pin,
            "bvn": bvn,
            "tenantid": tenantId
        ]

        apiService.postRequest(endpoint: .verifyAppPin, parameters: parameters) { (result: Result<LendingVerifyPinResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    self.onVerifyUserSuccess?(response)
                } else {
                    // Handle failure case when response.success is false
                    self.onVerifyUserFailure?(response.message)
                }
            case .failure(let error):
                // Handle other API errors (network, decoding, etc.)
                self.onError?(error.localizedDescription)
            }
        }
    }
}
