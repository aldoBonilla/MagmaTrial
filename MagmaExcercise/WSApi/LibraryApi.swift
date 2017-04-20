//
//  LibraryApi.swift
//  KokonutTemplate
//
//  Created by Aldo Bonilla on 01/09/16.
//  Copyright © 2016 Aldo Bonilla. All rights reserved.
//  Here is were you put all your web calls

import Foundation
import Alamofire
 
class LibraryApi {
    
    static let sharedInstance = LibraryApi()
    
    //TODO: change this URL for the server you are using
    private let Server = "https://soliduxample.herokuapp.com/api/products.json?token=ddcd14bbe6699211f8e157ca9b6812d9c699617c9a72caf7"
    
    
    func getProducts(_ onCompletition: @escaping (([Product]?, NSError?)) -> ()) {
        WSApi.sharedInstance.serviceWithURL(url: Server, method: .GET, parameters: nil, onCompletition: { response, error in
            if error != nil { onCompletition((nil, error)) }
            else {
                guard let objects = response?["products"] as? [BasicDictionary] else {
                    onCompletition((nil, NSError(domain: "Library", code: -1, userInfo: ["error" : "Couldnt load products"])))
                    return
                }
                let mappedProducts = objects.map({Product(dictionary: $0)})
                onCompletition((mappedProducts, nil))
            }
        })
    }
    
}
