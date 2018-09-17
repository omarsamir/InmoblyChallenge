//
//  Interactor.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper

class Interactor: NSObject {
    
   static func getFlickrPhotos(completion: @escaping (_ result: FlickrResource?, _ error: Error?) -> Void) {
        let url = URL(string: Constants.RESOURCES_URL)
        var request : URLRequest = URLRequest(url: url!)
        request.httpMethod = Constants.HTTPREQUEST_TYPE_GET
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
            if error == nil {
                let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: [])
                if let theJSONData = try? JSONSerialization.data(
                    withJSONObject: responseDictionary,
                    options: []) {
                    let theJSONText = String(data: theJSONData,
                                             encoding: .ascii)
                    let flickrResource : FlickrResource = FlickrResource(JSONString: theJSONText!)!
                    completion (flickrResource,nil)
                }
            }else{
                completion (nil,error)
            }
        }
        dataTask.resume()
    }
}
