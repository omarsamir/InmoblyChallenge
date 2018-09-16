//
//  Interactor.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class Interactor: NSObject {
    
   static func getFlickrPhotos(completion: @escaping (_ result: FlickrResource?, _ error: Error?) -> Void) {
    
    
    Alamofire.request(Constants.RESOURCES_URL).responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        if let json = response.result.value {
            print("JSON: \(json)") // serialized json response
        }
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
           
            let flickrResource : FlickrResource = FlickrResource(JSONString: utf8Text)!
             print("Data: \(utf8Text)") // original server data as UTF8 string
        }
    }
    
//        let url = URL(string: Constants.RESOURCES_URL)
//        var request : URLRequest = URLRequest(url: url!)
//        request.httpMethod = Constants.HTTPREQUEST_TYPE_GET
//        let dataTask = URLSession.shared.dataTask(with: request) {
//            data,response,error in
//            if error == nil {
////                let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: [])
//                let theJSONText =response.res
//                let flickrResource : FlickrResource = FlickrResource(JSONString: theJSONText!)!
//                                    completion (flickrResource,nil)
//
////                if let theJSONData = try? JSONSerialization.data(
////                    withJSONObject: responseDictionary,
////                    options: []) {
////                    let theJSONText = String(data: theJSONData,
////                                             encoding: .ascii)
////                    let flickrResource : FlickrResource = FlickrResource(JSONString: theJSONText!)!
////                    completion (flickrResource,nil)
////                }
//            }else{
//                completion (nil,error)
//            }
//        }
//        dataTask.resume()
    }
}
