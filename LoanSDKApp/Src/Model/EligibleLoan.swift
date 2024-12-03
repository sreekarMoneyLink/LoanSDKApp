//
//  ViewController.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import Foundation
import UIKit

class EligibleLoan: Codable {
    
    var id: Int?
    var bankName: String?
    var bankIcon: String?
    var eligibleAmount: Int?
    var interest: CGFloat?
    var tenure: CGFloat?
    var fee: CGFloat?
    
    
    enum CodingKeys: String, CodingKey {
        case bankName, bankIcon, eligibleAmount, interest, tenure, id, fee
    }

}

// MARK: - Response
struct LoanEligibilityResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: LoanEligibilityData?
    
    struct LoanEligibilityData: Codable {
        let interest: String
        let eligibleAmount: String
        let fee: String
        let id: String
        let bankName: String
        let bankIcon: String
        let tenure: String
        
        // Custom keys to match the JSON field names
        enum CodingKeys: String, CodingKey {
            case interest
            case eligibleAmount = "eligibleamount"
            case fee
            case id
            case bankName = "bankname"
            case bankIcon = "bankicon"
            case tenure
        }
    }
}

struct LoanResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: LoanData?
}

struct LoanData: Codable {
    let loantenor: String
    let interest: String
    let eligibleAmount: String
    let fee: String
    let creditLifeInsurance: String
    let tenure: String
    let latefee: String

    enum CodingKeys: String, CodingKey {
        case loantenor
        case interest
        case eligibleAmount = "eligibleamount"
        case fee
        case creditLifeInsurance = "creditlifeinsurance"
        case tenure
        case latefee
    }
}

struct LoanSubmissionResponse: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: LoanDetails?
}

struct LoanDetails: Codable {
    let approvalStatus: Bool
    let bankAccountNumber: String
    let eligibleAmount: String
    let bankName: String
    let bankIcon: String

    enum CodingKeys: String, CodingKey {
        case approvalStatus = "approvalstatus"
        case bankAccountNumber = "bankaccountnumber"
        case eligibleAmount = "eligibleamount"
        case bankName = "bankname"
        case bankIcon = "bankicon"
    }
}
