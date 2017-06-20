//
//  NetworkManager.swift
//  Breezer
//
//  Created by Admin on 27.03.17.
//  Copyright © 2017 grapes-studio. All rights reserved.
//

import Foundation
import Alamofire


let strNoInternetConnection = "Нет подключения к сети"
let strOtherError = "Непредвиденная ошибка"

extension ServiceError {
    init(json: JSON) {
        if let message =  json["message"] as? String {
            self = .custom(message)
        } else {
            self = .other
        }
    }
}

typealias NetworkCompletion = (_ json: JSON?, _ error: Error?) -> Void

public class NetworkManager
{
    static let shared = NetworkManager()
    fileprivate let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    init() {
        //start listening network connection
        self.reachabilityManager?.startListening()
    }
    
    //stoping services
    deinit {
        self.reachabilityManager?.stopListening()
    }
    
    fileprivate func acceptResponse(_ response: DataResponse<Any>?, _ completion: NetworkCompletion)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let httpResponse = response?.response, (200..<300) ~= httpResponse.statusCode{
            completion(response?.result.value as? JSON, nil)
        } else {
            var error : ServiceError? = nil
            if let valueError = (response?.result.value as? JSON).flatMap(ServiceError.init)
            {
                error = valueError
            }
            else if let valueError = (response?.result.error) {
                error = ServiceError.custom(valueError.localizedDescription)
            }
            else{
                error = ServiceError.other
            }
            completion(nil, error)
        }
    }
    
    fileprivate func sendRequest(_ url: URLConvertible,
                     method: HTTPMethod = .get,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil, completion: @escaping NetworkCompletion)
    {
        if (reachabilityManager?.isReachable == false)
        {
            completion(nil, ServiceError.noInternetConnection)
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON {
            [unowned self] response in
            self.acceptResponse(response, completion)
        }
    }
    
    //send sign in request
    func signInWith(email :String!, password : String!, completion: @escaping NetworkCompletion)
    {
        
        //generate parameters
        let parameters: JSON = [
            "email": email,
            "password":password,
            "set_cookie":true,
            "service":ServiceID
        ]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        sendRequest(SignInServerURL, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: nil, completion: completion)
    }
}
