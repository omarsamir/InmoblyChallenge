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
    func loadFlickrNasaPhotos () {
        Interactor.getFlickrPhotos { (flickerResource, error) in
            if error == nil {
                self.delegate?.display(flickrResources: flickerResource!)
            }else{
                self.delegate?.display(error: error!)
            }
        }
    }
}
