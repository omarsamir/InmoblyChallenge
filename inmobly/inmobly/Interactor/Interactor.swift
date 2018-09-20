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
    
//  global variables for recursive function saveFlickrImageRecources
    var globalIndex: Int = 0
    var globalFlickrResource: FlickrResource!
    
    //MARK: Get Flicker images
    
    func getFlickrPhotos(isManualUpdate: Bool, completion: @escaping (_ result: FlickrResource?, _ error: Error?) -> Void) {
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
                    
                    if isManualUpdate {
                        // If manual update by pull to refresh delete all records and save new images
                        DispatchQueue.global().async {
                            self.deleteAllImageRecords()
                            self.saveFlickrResourceImagesInDatabase()
                        }
                    }else{
                        self.retriveImagesFromDatabase()
                    }
                    completion (flickrResource,nil)
                }
            }else{
                completion (nil,error)
            }
        }
        dataTask.resume()
    }
    
    //MARK: CoreData Methods
    
    //Save Image in Nasa_Images Entity
    func saveImageInDatabase(imageData: Data) {
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
    
    //Retrive all Images in Nasa_Images Entity
    func retriveImagesFromDatabase()->[UIImageView]{
        var images : [UIImageView] = []
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.NASA_IMAGES_ENTITY_NAME)
        do {
            let imagesDataArray = try self.managedObjectContext.fetch(fetchRequest)
            for resource in imagesDataArray {
                let img : UIImage = UIImage(data: resource.value(forKeyPath: Constants.NASA_IMAGES_IMAGE_DATA_PROPERTY_NAME) as! Data)!
                DispatchQueue.main.async {
                    images.append(UIImageView (image: img))
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return images
    }
    
    //Delete all Images in Nasa_Images Entity
    func deleteAllImageRecords(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.NASA_IMAGES_ENTITY_NAME)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? managedObjectContext.execute(request)
    }
    
    //Save all Flickr Images resource [Recursive function]
    func saveFlickrResourceImagesInDatabase(){
        let url = URL(string: (globalFlickrResource.photos?.photo![globalIndex].urlM)!)
        let request : URLRequest = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            if  error == nil {
                    self.saveImageInDatabase(imageData: UIImagePNGRepresentation(image)!)
            }
            if self.globalIndex < (self.globalFlickrResource.photos?.photo?.count)! - 1 {
                self.globalIndex = self.globalIndex + 1
                self.saveFlickrResourceImagesInDatabase()
            }
            }.resume()
    }

}
