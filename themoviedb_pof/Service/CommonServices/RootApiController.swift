//
//  RootApiController.swift
//
//
//  Created by Roman Ustiantcev on 11/23/17.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct APIError {
    let domain: String
    enum code: Int {
        case Unauthorized
        case NotFound
        case InternalServerError
    }
}

struct APIResponse {
    let statusCode: Int
    let json: JSON
    let bodyResponse: String?
}

struct APIRequest {
    let method: Alamofire.HTTPMethod
    let endpoint: String
    let parameters: [String: Any]?
    let encoding: ParameterEncoding?
}


class RootApiController {
    
    private let baseURL = ClientConfig.ApiScheme + ClientConfig.ApiHost + ClientConfig.ApiPath
    private let queue = DispatchQueue(label: "com.ruResponse.response-queue", qos: .userInteractive, attributes: [.concurrent])
    
    private func queryItems(dictionary: [String:String]) -> [URLQueryItem] {
        return dictionary.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    
    func getData(method: Alamofire.HTTPMethod = .post,
                 endpoint: String,
                 parameters: [String: String]? = nil,
                 body: [String: Any]? = nil,
                 completionHandler: @escaping (APIResponse)->(),
                 errorHandler: ((String) -> ())? = nil) {
        
        let urlString: String = baseURL + endpoint
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
  
        var components = URLComponents.init(url: url, resolvingAgainstBaseURL: true)
        if let parameters = parameters {
            components?.queryItems = queryItems(dictionary: parameters)
        }
        
        var request = URLRequest(url: components!.url!)
        request.httpMethod = method.rawValue
        
        if body != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body!)
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

        Alamofire.request(request)
//        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default)
            .response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer()) { (response) in
        
            if response.result.isFailure == true {
                let error = response.result.error
                print(error!.localizedDescription)
                errorHandler?(error!.localizedDescription)
                return
            }
            
            guard response.result.value != nil else {
                print("Response result is nil")
                errorHandler?("Internal server error")
                return
            }
            
            let statusCode = response.response!.statusCode
            
            let jsonWithObjectRoot = try! JSONSerialization.jsonObject(with: response.data!)
            guard let dictionary = jsonWithObjectRoot as? [String: Any] else {return}
            let statusMessage = dictionary["status_message"] as? String ?? ""
            
            switch statusCode {
            case 401:
                errorHandler?(statusMessage)
                return
            case 404:
                errorHandler?(statusMessage)
                return
            case 500:
                let error = "Internal server error"
                errorHandler?(error)
                return
            default:
                break
            }
            
            let json = JSON(response.result.value!)
            
            guard json != JSON.null else {
                print("Error parsing JSON")
                errorHandler?("Internal server error")
                return
            }
            
            if let error = json["error"].string {
                errorHandler?(error)
                return
            }
            
            let bodyResponse = String(data: response.data!, encoding: String.Encoding.utf8)           
            completionHandler(APIResponse(statusCode: response.response?.statusCode ?? 0, json: json, bodyResponse: bodyResponse))
        }
    }
}
