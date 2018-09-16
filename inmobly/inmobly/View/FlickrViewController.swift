//
//  FlickrViewController.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit

class FlickrViewController: UIViewController,PresenterDelegate {

    var presenter: Presenter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter()
        presenter.delegate = self
        presenter.loadFlickrNasaPhotos()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Implement presenter delegate methods
    func display(flickrResources: FlickrResource) {
        print("")
    }
    
    func display(error: Error) {
      print("")
    }

}
