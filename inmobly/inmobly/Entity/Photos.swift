//
//  Photos.swift
//  inmobly
//
//  Created by Omar Samir on 9/17/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper

class Photos: NSObject,Mappable {
    var page, pages, perpage, total: Int!
    var photo: [Photo]!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        page    <- map["page"]
        pages   <- map["pages"]
        perpage <- map["perpage"]
        total   <- map["total"]
        photo   <- map["photo"]
    }
}
