//
//  FlickrResource.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper

class FlickrResource: NSObject, Mappable {
    var photos: Photos!
    var stat: String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        photos <- map["photos"]
        stat   <- map["stat"]
       
    }
}
