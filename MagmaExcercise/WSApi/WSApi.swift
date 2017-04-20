//
//  WSApi.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 22/08/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Centraliza las llamadas web en una sola clase, si cambiamos el framework solo sera necesario hacer cambios en esta clase

import Foundation
import Alamofire

enum webMethod: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

class WSApi {
    
    static let sharedInstance = WSApi()
    
    var manager: NetworkReachabilityManager?
    
    func serviceWithURL(url: String, method: webMethod, parameters: BasicDictionary?, onCompletition:@escaping ((_ response: BasicDictionary?, _ error: NSError?) -> ())) {
        setupReachability()
        if manager?.networkReachabilityStatus == .notReachable {
            onCompletition(nil, NSError(domain: "WSApi", code: -1, userInfo: nil))
            return
        }
        Alamofire.request(url, method: Alamofire.HTTPMethod(rawValue: method.rawValue)!, parameters: parameters, encoding: JSONEncoding.default)
                 .validate()
                 .responseJSON(completionHandler: { response in
                    guard response.result.isSuccess else {
                        //Analytics.sharedInstance.logEvent(name: .ServiceError, parameters: ["Service" : url, "Parameters" : parameters ?? [:]])
                        print("response failed for service: \(url)")
                        onCompletition(nil, NSError(domain: "WSApi", code: response.response?.statusCode ?? -1, userInfo: nil))
                        return
                    }
                    guard let json = response.result.value as? BasicDictionary else {
                        //Analytics.sharedInstance.logEvent(name: .ServiceError, parameters: ["Service" : url, "Parameters" : parameters ?? [:]])
                        onCompletition(nil, NSError(domain: "WSApi", code: -2, userInfo: nil))
                        return
                    }
                    onCompletition(json, nil)
                
                 })
    }
    
    func serviceMultipart(url: String, image: UIImage, params : [String: String], opcionalParams : [String: Int], onCompletition:@escaping ((_ response: BasicDictionary?, _ error: NSError?) -> ())) {
        setupReachability()
        if manager?.networkReachabilityStatus == .notReachable {
            onCompletition(nil, NSError(domain: "WSApi", code: -1, userInfo: nil))
            return
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let imageData = UIImagePNGRepresentation(image) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
            }
            
            for (key, value) in opcionalParams {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for (key, value) in params {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }}, to: url, method: .post, headers: ["Authorization": "auth_token"], encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON (completionHandler: { response in
                        guard response.result.isSuccess else {
                            print("response failed for service: \(url)")
                            onCompletition(nil, NSError(domain: "WSApi", code: response.response?.statusCode ?? -1, userInfo: nil))
                            return
                        }
                        guard let json = (response.response?.statusCode) else {
                            return
                        }
                        
                        if json >= 400 {
                            onCompletition(nil, NSError(domain: "WSApi", code: -2, userInfo: nil))
                            let newjson = response.result.value as! BasicDictionary
                            print(newjson)
                        } else {
                        let newjson = response.result.value as! BasicDictionary
                        onCompletition(newjson, nil)
                        print(json)
                        debugPrint(response)
                        }
                    })
                    
                case .failure(let encodingError):
                    print("error:\(encodingError)")
                }
        })
    }
    
    func setupReachability() {
        if manager != nil { return }
        manager = NetworkReachabilityManager(host: "www.apple.com")
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        manager?.startListening()
    }
}
