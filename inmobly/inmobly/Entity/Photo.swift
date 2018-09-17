//
//  Photo.swift
//  inmobly
//
//  Created by Omar Samir on 9/17/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper

class Photo: NSObject,Mappable {
    var id: String?
    var owner: String?
    var secret, server: String?
    var farm: Int?
    var title: String?
    var ispublic, isfriend, isfamily: Int?
    var urlM: String?
    var heightM, widthM: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id       <- map["id"]
        owner    <- map["owner"]
        secret   <- map["secret"]
        server   <- map["server"]
        farm     <- map["farm"]
        title    <- map["title"]
        ispublic <- map["ispublic"]
        isfriend <- map["isfriend"]
        isfamily <- map["isfamily"]
        urlM     <- map["url_m"]
        heightM  <- map["heightM"]
        widthM   <- map["widthM"]
        
    }
}
