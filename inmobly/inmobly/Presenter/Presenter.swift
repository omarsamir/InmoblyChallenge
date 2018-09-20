//
//  Presenter.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit

protocol PresenterDelegate : AnyObject {
    func display(flickrResources:FlickrResource)
    func display(error: Error)
}
class Presenter: NSObject {
    weak var delegate : PresenterDelegate?
    let interactor : Interactor = Interactor()
    
    func loadFlickrNasaPhotos (isManualUpdate: Bool) {
    interactor.getFlickrPhotos(isManualUpdate: isManualUpdate) { (flickerResource, error) in
        if error == nil {
                 DispatchQueue.main.async {
                    self.delegate?.display(flickrResources: flickerResource!)
                }
            }else{
                 DispatchQueue.main.async {
                    self.delegate?.display(error: error!)
                }
            }
        }
    }
    
    func manualUpdateFlickerNasaPhotos(){
        interactor.deleteAllImageRecords()
        loadFlickrNasaPhotos(isManualUpdate: true)
    }
}
