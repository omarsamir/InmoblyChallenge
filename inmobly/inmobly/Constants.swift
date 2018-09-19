//
//  Constants.swift
//  inmobly
//
//  Created by Omar Samir on 9/17/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let RESOURCES_URL = "https://api.flickr.com/services/rest/?method=flickr.photos.getPopular&api_key=3b1314104594a6b62e1cb26f7edbcd73&user_id=24662369@N07&format=json&extras=url_m,url_l&nojsoncallback=?"
    static let HTTPREQUEST_TYPE_GET = "GET"
    static let COLLECTION_VIEW_CELL_ID = "FlickrCollectionViewCellId"
    static let GREY_PLACEHOLDER_IMAGE_NAME = "gray-placeholder"
    static let NASA_IMAGES_ENTITY_NAME = "Nasa_Images"
    static let NASA_IMAGES_IMAGE_DATA_PROPERTY_NAME = "imageData"
}
