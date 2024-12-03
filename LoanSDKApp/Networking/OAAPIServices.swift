import Foundation
import UIKit
@_exported import Alamofire

enum APIError: Error {
    case unknown
    case serverError(String)
    case decodingError(String)
}


class OAAPIServices {
    
    private let baseURL = "https://api-dev.montra.org" // Adjusted base URL for the specific API
    
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
        
        AF.request(url, method: .get, headers: requestHeaders).validate().responseDecodable(of: T.self) { response in
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
        print("Payload", parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders).validate().responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let decodedResponse):
                completion(.success(decodedResponse))
            case .failure(let error):
                let apiError = self.mapError(error)
                completion(.failure(apiError))
            }
        }
    }
    
    func postRequestWithOutParameters<U: Decodable>(endpoint: APIEndpoint, headers: HTTPHeaders? = nil, completion: @escaping (Result<U, Error>) -> Void) {
        let url = "\(baseURL)\(endpoint.rawValue)"
        let requestHeaders = headers ?? defaultHeaders
        
        print("Url ===>\(url)")
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: requestHeaders).validate().responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let decodedResponse):
                completion(.success(decodedResponse))
            case .failure(let error):
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
}
