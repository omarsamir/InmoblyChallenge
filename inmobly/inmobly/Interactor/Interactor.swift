//
//  Interactor.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreData

class Interactor: NSObject {
    
    let managedObjectContext : NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var globalIndex: Int = 0
    var globalFlickrResource: FlickrResource!
    
    func getFlickrPhotos(completion: @escaping (_ result: FlickrResource?, _ error: Error?) -> Void) {
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
                    self.globalFlickrResource = flickrResource
//                    self.saveFlickrImageRecources()
//                    self.deleteAllImageRecords()
                    self.retriveImgage()
                    completion (flickrResource,nil)
                }
            }else{
                completion (nil,error)
            }
        }
        dataTask.resume()
    }
    
    
    func saveImage(imageData: Data) {
        let entity =
            NSEntityDescription.entity(forEntityName: Constants.NASA_IMAGES_ENTITY_NAME,
                                       in: self.managedObjectContext)!
        let nasaImages = NSManagedObject(entity: entity,
                                     insertInto: self.managedObjectContext)
        nasaImages.setValue(imageData, forKeyPath: Constants.NASA_IMAGES_IMAGE_DATA_PROPERTY_NAME)
        do {
            try self.managedObjectContext.save()
            print("Image #" + String(globalIndex) + "Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retriveImgage(){
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.NASA_IMAGES_ENTITY_NAME)
        do {
            let pp = try self.managedObjectContext.fetch(fetchRequest)
            var img : UIImage = UIImage(data: pp[0].value(forKeyPath: Constants.NASA_IMAGES_IMAGE_DATA_PROPERTY_NAME) as! Data)!
            print("")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllImageRecords(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.NASA_IMAGES_ENTITY_NAME)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? managedObjectContext.execute(request)
    }
    
    func saveFlickrImageRecources(){
        let url = URL(string: (globalFlickrResource.photos?.photo![globalIndex].urlM)!)
        let request : URLRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            if  error == nil {
                    self.saveImage(imageData: UIImagePNGRepresentation(image)!)
            }
         if self.globalIndex < (self.globalFlickrResource.photos?.photo?.count)! - 1 {
                self.globalIndex = self.globalIndex + 1
                self.saveFlickrImageRecources()
            }
            }.resume()
    }

}
