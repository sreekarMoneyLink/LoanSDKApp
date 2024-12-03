//
//  VerifyPinResponse.swift
//  LendingSDK
//
//  Created by Rex on 25/11/24.
//

import Foundation


struct LendingVerifyPinResponse: Decodable {
    let success: Bool
    let code: String
    let message: String
}
