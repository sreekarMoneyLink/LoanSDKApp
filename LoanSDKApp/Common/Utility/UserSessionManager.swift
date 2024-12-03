//
//  UserManager.swift
//  OA
//
//  Created by consultant5 on 08/10/24.
//

import Foundation
// UserSessionManager.swift

class UserSessionManager {
    
    // MARK: - Properties
    static let shared = UserSessionManager()
    // Store bvn
    private(set) var bvn: String?
    // Store tenantId
    private(set) var tenantId: String? = ""
    private(set) var cardId: String? = ""
    private(set) var custName: String? = ""
    private(set) var channelId: String? = ""
    private(set) var mobileNo: String? = ""
    private(set) var cardNo: String? = ""
    private(set) var custId: String? = ""
    private(set) var isBvnExist: Bool? = false
    private(set) var phoneNumber: String? = ""
    // Store verifyedId
    private(set) var verifyedId: String?
    
    // MARK: - Initializer
    // Private initializer to prevent creating new instances from outside
    private init() {}
    
    // MARK: - Methods
    func setVerifyedId(_ id: String) {
        verifyedId = id
    }
    
    func setPhoneNumberId(_ id: String) {
        phoneNumber = id
    }
    
    func clearVerifyedId() {
        verifyedId = nil
    }
    
    func clearPhoneNumberId() {
        phoneNumber = nil
    }
    
    // MARK: - Methods
    func setbvn(_ id: String) {
        bvn = id
    }
    
    func setcardId(_ id: String) {
        cardId = id
    }
    
    func setmobileNo(_ mobile: String) {
        mobileNo = mobile
    }
    
    func setunMaskedCardNo(_ num: String) {
        cardNo = num
    }
    
    func clearbvn() {
        bvn = nil
    }
    
    func clearcardNo() {
        cardNo = nil
    }
    
    func settenantId(_ id: String) {
        tenantId = id
    }
    
    func setcustName(_ name: String) {
        custName = name
    }
    
    func setChannelId(_ id: String) {
        channelId = id
    }
    
    func setcustId(_ id: String) {
        custId = id
    }
    
    func setIsBvnExist(_ num: Bool) {
        isBvnExist = num
    }
    
    func clearIsBvn() {
        isBvnExist = false
    }
    
    func clearcustId() {
        custId = nil
    }
    
    func cleartenantId() {
        tenantId = nil
    }
     
    func clearcardId() {
        cardId = nil
    }
    
    func clearchannelId() {
        channelId = nil
    }

    func clearcustName() {
        custName = nil
    }


}

//// How to use
//
//// Set verifyedId
//UserSessionManager.shared.setVerifyedId("9129082024@veri.ng")
//
//// Access verifyedId
//if let verifyedId = UserSessionManager.shared.verifyedId {
//    print("Current verifyedId is: \(verifyedId)")
//}
//
//// Clear verifyedId
//UserSessionManager.shared.clearVerifyedId()
//
