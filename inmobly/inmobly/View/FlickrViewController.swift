//
//  FlickrViewController.swift
//  inmobly
//
//  Created by Omar Samir on 9/16/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit
import ObjectMapper

class FlickrViewController: UIViewController,PresenterDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var nasaImagesCollectionView: UICollectionView!
    var presenter: Presenter! = nil
    var mainFlickrResource : FlickrResource!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = Presenter()
        presenter.delegate = self
        presenter.loadFlickrNasaPhotos(isManualUpdate: false)
        configureCollectionView()
        configurePullToRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func refresh(){
        presenter.loadFlickrNasaPhotos(isManualUpdate: true)
    }
    
    // MARK: View did Load Pre-Configutarion
    func configureCollectionView(){
        self.nasaImagesCollectionView.register(UINib(nibName: String(describing: FlickrCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier:Constants.COLLECTION_VIEW_CELL_ID)
        self.nasaImagesCollectionView.delegate = self
        self.nasaImagesCollectionView.dataSource = self
    }
    
    func configurePullToRefresh(){
        self.refreshControl.attributedTitle = NSAttributedString(string: "Getting Images from Flickr")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.nasaImagesCollectionView.addSubview(refreshControl)
    }
    
    // MARK: Implement presenter delegate methods
    func display(flickrResources: FlickrResource) {
        mainFlickrResource = flickrResources
        refreshControl.endRefreshing()
        nasaImagesCollectionView.reloadData()
    }
    
    func display(error: Error) {
        let alert = UIAlertController(title: "Error Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Implement Collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainFlickrResource == nil {
            return 0
        }else{
            return (mainFlickrResource.photos?.photo?.count)!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FlickrCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_ID,
                                                                                for: indexPath) as! FlickrCollectionViewCell
        cell.flickrImage.sd_setImage(with: URL(string: (mainFlickrResource.photos?.photo![indexPath.row].urlM)!), placeholderImage: UIImage(named: Constants.GREY_PLACEHOLDER_IMAGE_NAME), options: .refreshCached, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let fullScreenVC = FullScreenViewController(nibName: String(describing: FullScreenViewController.self), bundle: nil)
        fullScreenVC.flickrResource = mainFlickrResource
        fullScreenVC.photoIndex = indexPath.row
        self.present(fullScreenVC, animated: true, completion: nil)
    }
}
