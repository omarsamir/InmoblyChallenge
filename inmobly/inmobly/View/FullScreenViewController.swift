//
//  FullScreenViewController.swift
//  inmobly
//
//  Created by Omar Samir on 9/20/18.
//  Copyright © 2018 Omar Samir. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {
    @IBOutlet weak var fullScreenScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var flickrResource: FlickrResource!
    var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullScreenScrollView.isPagingEnabled = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayNasaImages()
        openImageFullScreen()
    }

    // MARK: Images scrollView methods
    //Display Nasa images scroll view
    func displayNasaImages(){
        var count: Int = 0
        var viewFrameX: CGFloat = 0.0
        let width = self.fullScreenScrollView.frame.size.width
        let height = self.fullScreenScrollView.frame.size.height
        for photo in (flickrResource.photos?.photo)! {
            count = count + 1
            if (photo.urlL == nil && photo.urlM == nil){
                continue
            }else{
                let fullScreenImage : UIImageView = UIImageView(frame: CGRect(x: viewFrameX, y: 0, width: width, height: height))
                fullScreenImage.sd_setImage(with: URL(string: (photo.urlL != nil) ? photo.urlL! : photo.urlM!), placeholderImage: UIImage(named: Constants.GREY_PLACEHOLDER_IMAGE_NAME), options: .refreshCached, completed: nil)
                fullScreenImage.contentMode = .scaleAspectFit
                self.fullScreenScrollView.addSubview(fullScreenImage)
                viewFrameX = viewFrameX + width
            }
        }
        var contentSize = self.fullScreenScrollView.frame.size
        contentSize.width = viewFrameX
        contentSize.height = 0.0
        self.fullScreenScrollView.contentSize = contentSize
    }
    
    //Open Image in Full screen according to 'photoIndex'
    func openImageFullScreen(){
        self.fullScreenScrollView.setContentOffset(CGPoint(x: CGFloat(photoIndex) * self.fullScreenScrollView.frame.size.width, y: 0), animated: false)
    }
    
    // MARK: Actions
    @IBAction func dismissFullScreenModeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
