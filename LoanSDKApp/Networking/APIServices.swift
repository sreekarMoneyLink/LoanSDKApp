import Foundation
import UIKit
@_exported import Alamofire

//enum APIError: Error {
//    case unknown
//    case serverError(String)
//    case decodingError(String)
//}

enum APIEndpoint: String {
    case instacardList = "/instacard/api/v1/listofinstacards"
    case bvnLinkedAccounts = "/instacard/api/v1/listofbvnlinkedaccounts"
    case verifyAppPin = "/instacard/api/v1/verifyapppin"
    case addnewcard = "/instacard/api/v1/addnewcard"
    case getCardDetail = "/instacard/api/v1/getcarddetail"
    case setPin = "/instacard/api/v1/setpin"
    case verifyinstapin = "/instacard/api/v1/verifypin"
    case paymentLimits = "/instacard/api/v1/paymentlimits"
    case updatePaymentLimit = "/instacard/api/v1/updatepaymentlimit"
    case unblockCard = "/instacard/api/v1/unblockcard"
    case blockCard = "/instacard/api/v1/blockcard"
    case creditCardOutstanding = "/instacard/api/v1/creditcardoutstanding"
    case changePin = "/instacard/api/v1/changepin"
    case addUniversalCard = "/instacard/api/v1/adduniversalcard"
    case listOfUniversalCards = "/instacard/api/v1/listofuniversalcard"
    case unbilledTransactions = "/instacard/api/v1/unbilledcardtransaction"
    case addMoney = "/instacard/api/v1/addmoney"
    case unmaskedCardDetails = "/instacard/api/v1/unmaskedcarddetails"
    case debitCardTransaction = "/instacard/api/v1/debitcardtransaction"
    case rePayment = "/instacard/api/v1/repayment"
    case crediteligibility = "/instacard/api/v1/crediteligibility"
    case faceLiveness = "/instacard/api/v1/faceliveliness"
    case bvnVerification = "/verifyed/api/v1/sbvnverification"
    case bvnDetails = "/instacard/api/v1/getbvndetails"
    case sendOtp = "/instacard/api/v1/sendotp"
    case verifyOtp = "/instacard/api/v1/verifyotp"
    case getWalletAccountDetails = "/instacard/api/v1/getwalletInfo"
    case allTransaction = "/instacard/api/v1/alltransaction"
    case validateSoftToken = "/verifyed/api/v1/svalidatesofttoken"
    case openAccount = "/verifyed/api/v1/sopenaccount"
    case oasendOtp = "/verifyed/api/v1/ssendotp"
    case oafaceLiveness = "/verifyed/api/v1/sbvnfaceliveliness"
    case getuserDetails = "/kyc/v1/getverifymeuserdetails"
    case savePersonalInfo = "/verifyed/api/v1/ssavepersonalinfo"
    case getAccountInfo = "/verifyed/api/v1/sgetkyclevelwithacctdetails"
    case faceLivelinessVerification = "/verifyed/api/v1/sninfaceliveliness"
    case upgradeKYCLevel = "/verifyed/api/v1/supgradenextkyclevel"
    case oaverifyOtp = "/verifyed/api/v1/sverifyotp"
    case bvnVerificationDetails = "/verifyed/api/v1/sbvnverificationdetails"
    case ninVerificationDetails = "/verifyed/api/v1/sninverificationdetails"
    case idVerification = "/verifyed/api/v1/sidverification"
    case addressVerificationStatus = "/kyc/v1/addressverificationstatus"
    case proofOfAddress = "/verifyed/api/v1/sproofofaddress"
    case serviceProvider = "/verifyed/api/user/v1/getListOfElectricityProviders"
    case verifyUser = "/verifyed/api/v1/sverifyuser"
    case generateQrCode = "/verifyed/api/v1/sgenerateqrcode"
    case removecard = "/instacard/api/v1/deletecard"
    case getBusinessCategory = "/merchant/api/v1/get/categories"
    case getBusinessSubCategory = "/merchant/api/v1/get/subcategories"
    case loanEligibility = "/customer/api/v1/loanelg"
    case applyLoan = "/customer/api/v1/applyloan"
    case submitLoan = "/customer/api/v1/submitloan"
     
}

class APIService {
    
    var loader: UIActivityIndicatorView?
    private let baseURL = "https://api-dev.montra.org"
    //"http://34.255.139.130:8109"
    //"https://api-dev.montra.org" // Adjusted base URL for the specific API
    
    // Define default headers, such as Authorization and Content-Type
    private var defaultHeaders: HTTPHeaders {
        return [
            "Authorization": "Bearer \(getToken())", // Retrieve your token dynamically
            "Content-Type": "application/json"
        ]
    }
    
    private func getToken() -> String {
        // Implement your token retrieval logic here
        return "your_access_token" // Replace with actual token retrieval logic
    }

    // Function for GET requests
    func getRequest<T: Decodable>(endpoint: APIEndpoint, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(baseURL)\(endpoint.rawValue)"
        let requestHeaders = headers ?? defaultHeaders
        if let currentViewController = getTopViewController()
        {
            self.showLoader(inviewController: currentViewController)
        }
        AF.request(url, method: .get, headers: requestHeaders).validate().responseDecodable(of: T.self) { response in
            if let currentViewController = self.getTopViewController()
            {
                self.hideLoader(inviewController: currentViewController)
            }
            switch response.result {
            case .success(let decodedResponse):
                completion(.success(decodedResponse))
            case .failure(let error):
                let apiError = self.mapError(error)
                completion(.failure(apiError))
            }
        }
    }

    // Function for POST requests using a dictionary
    func postRequest<U: Decodable>(endpoint: APIEndpoint, parameters: [String: Any], headers: HTTPHeaders? = nil, completion: @escaping (Result<U, Error>) -> Void) {
        let url = "\(baseURL)\(endpoint.rawValue)"
        let requestHeaders = headers ?? defaultHeaders
        
        print("Url ===>\(url)")
        print("Request ==>",parameters)
        if let currentViewController = getTopViewController()
        {
            self.showLoader(inviewController: currentViewController)
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).validate().responseDecodable(of: U.self) { response in
            print("Response ==>",response)
            switch response.result {
            case .success(let decodedResponse):
                
                DispatchQueue
                    .main.async {
                        if let currentViewController = self.getTopViewController()
                        {
                            self.hideLoader(inviewController: currentViewController)
                        }
                    }
                        completion(.success(decodedResponse))
            case .failure(let error):
                
                DispatchQueue
                    .main.async {
                        if let currentViewController = self.getTopViewController()
                        {
                            self.hideLoader(inviewController: currentViewController)
                        }
                    }
                        let apiError = self.mapError(error)
                        completion(.failure(apiError))
                    }
            }
    }
    
    func postRequestWithOutParameters<U: Decodable>(endpoint: APIEndpoint, headers: HTTPHeaders? = nil, completion: @escaping (Result<U, Error>) -> Void) {
        let url = "\(baseURL)\(endpoint.rawValue)"
        let requestHeaders = headers ?? defaultHeaders
        
        print("Url ===>\(url)")
        if let currentViewController = getTopViewController()
        {
            self.showLoader(inviewController: currentViewController)
        }
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: requestHeaders).validate().responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let decodedResponse):
                DispatchQueue
                    .main.async {
                        if let currentViewController = self.getTopViewController()
                        {
                            self.hideLoader(inviewController: currentViewController)
                        }
                    }
                completion(.success(decodedResponse))
            case .failure(let error):
                DispatchQueue
                    .main.async {
                        if let currentViewController = self.getTopViewController()
                        {
                            self.hideLoader(inviewController: currentViewController)
                        }
                    }
                let apiError = self.mapError(error)
                completion(.failure(apiError))
            }
        }
    }
    
    
     func uploadDocument<U: Decodable>(endpoint: APIEndpoint, dto: [String: Any],
                                       imageDataView: UIImageView, fileName: String, mimeType: String, withName1:String, withName2:String,  completion: @escaping (Result<U, Error>) -> Void) {
        let urlString = "\(baseURL)\(endpoint.rawValue)"
        
        // Create a URL object from the string
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL))) // Handle invalid URL error
            return
        }
        
         // Convert dictionary to JSON data
         guard let dtoData = try?JSONSerialization.data(withJSONObject: dto, options: [])else{
             print ("Failed to serialize DTO to JSON" )
             return
        }
         guard let imageData = imageDataView.image?.jpegData(compressionQuality: 1.0)else {
             print ("Failed to convert image data" )
             return
        }
         AF.upload(multipartFormData: { multipartFormData in
             multipartFormData.append(dtoData, withName:withName1, mimeType:"application/json")
             multipartFormData.append(imageData, withName: withName2, fileName: fileName, mimeType: "image/jpg")
         },to: urlString)
         .validate()
         .responseDecodable(of: U.self) { response in
             print("Response: \(response)")
             print("Status Code: \(response.response?.statusCode ?? 0)")
             print("Response Data: \(String(data: response.data!, encoding: .utf8) ?? "No Response Data")")

             switch response.result {
             case .success(let decodedResponse):
                 completion(.success(decodedResponse))
             case .failure(let error):
                 let apiError = self.mapError(error)
                 completion(.failure(apiError))
             }
         }
    }
    

     
    
    private func mapError(_ error: AFError) -> APIError {
        switch error {
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                return .serverError("Server responded with status code: \(code)")
            default:
                return .unknown
            }
        case .responseSerializationFailed(let reason):
            return .decodingError("Failed to decode response: \(reason)")
        default:
            return .unknown
        }
    }
    
     func getTopViewController(base:UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = base as? UINavigationController {
            return getTopViewController(base: navigationController.visibleViewController)
            }
        
        if let tabBarController = base  as? UITabBarController {
            return getTopViewController(base: tabBarController.selectedViewController)
            }

        if let presentedViewController = base?.presentedViewController {
            return getTopViewController(base: presentedViewController)
            }

    return base
    }
    
    func showLoader(inviewController: UIViewController) {
    guard loader == nil else { return }
            loader = UIActivityIndicatorView(style: .large)
            loader?.center = inviewController.view.center
            inviewController.view.addSubview(loader!)
            loader?.startAnimating()
        }
     
    func hideLoader(inviewController: UIViewController) {
        loader?.stopAnimating()
        loader?.removeFromSuperview()
        loader = nil
    }
}
