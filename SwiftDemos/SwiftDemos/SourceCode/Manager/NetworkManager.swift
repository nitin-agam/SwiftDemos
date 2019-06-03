//
//  NetworkManager.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/05/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


// To enable or disable to logs for service requests.
let kDebug = true

public enum kHTTPMethod: String {
    case GET, POST
}

public enum ErrorType: Error {
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

class NetworkManager {
    
    // MARK: - Public Methods
    internal static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    
    func sendRequest(urlString: String,
                     method: kHTTPMethod,
                     parameters: Dictionary <String, Any>,
                     isLoader: Bool,
                     completion: @escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void {
        
        if isNetworkAvailable() {
            
            if isLoader {
                SVProgressHUD.show()
            }
            
            let serviceUrl = urlString
            log.value_api("\(LogManager.stats()) API Url: \(serviceUrl) with parameters: \(parameters)")/
            
            //NSAssert Statements
            assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            switch method {
            case .GET:
                Alamofire.request(serviceUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler:{ (DataResponse) in
                    
                    if isLoader {
                        SVProgressHUD.dismiss()
                    }
                    
                    switch DataResponse.result {
                    case .success(let JSON):
                        log.success_api("\(LogManager.stats()) API Response for url: \(serviceUrl) with response: \(JSON)")/
                        
                        let response = self.getResponseFromData(data: DataResponse.data!)
                        completion(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                        
                    case .failure(let error):
                        
                        log.error_api("\(LogManager.stats()) API Response for url: \(serviceUrl) with error: \(error.localizedDescription)")/
                        
                        if error.localizedDescription == "cancelled" {
                            completion(nil, error, .requestCancelled, DataResponse.response?.statusCode)
                        } else {
                            completion(nil, error, .requestFailed, DataResponse.response?.statusCode)
                        }
                    }
                })
            case .POST:
                Alamofire.request(serviceUrl, method: .post, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON(completionHandler:{ (DataResponse) in
                    
                    if isLoader {
                        SVProgressHUD.dismiss()
                    }
                    
                    switch DataResponse.result {
                    case .success(let JSON):
                        
                        log.success_api("\(LogManager.stats()) API Response for url: \(serviceUrl) with response: \(JSON)")/
                        
                        let response = self.getResponseFromData(data: DataResponse.data!)
                        completion(response.responseData,
                                   response.error,
                                   .requestSuccess,
                                   DataResponse.response?.statusCode)
                        
                    case .failure(let error):
                        log.error_api("\(LogManager.stats()) API Response for url: \(serviceUrl) with error: \(error.localizedDescription)")/
                        completion(nil, error, .requestFailed, DataResponse.response?.statusCode)
                    }
                })
            }
        } else {
            if isLoader {
                SVProgressHUD.dismiss()
            }
            completion(nil, nil, .noNetwork, nil)
        }
    }
    
    fileprivate func convertToData(_ value: Any) -> Data {
        if let string =  value as? String {
            return string.data(using: String.Encoding.utf8)!
        } else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
            return jsonData
        } else {
            return Data()
        }
    }
    
    private func getResponseFromData(data: Data) -> (responseData: Any?, error: Error?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return (responseData, nil)
        }
            
        catch let error {
            print(error.localizedDescription)
            return (nil, error)
        }
    }
    
    private func getCurrentTimeStamp()-> TimeInterval {
        return NSDate().timeIntervalSince1970.rounded();
    }
    
    func isNetworkAvailable() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
