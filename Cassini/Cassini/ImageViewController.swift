//
//  ImageViewController.swift
//  Cassini
//
//  Created by 임인혁 on 2018. 2. 3..
//  Copyright © 2018년 inorv. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: NSURL?{
        didSet{
            image = nil
            fetchImage()
        }
    }
    
    private func fetchImage(){
        if let url = imageURL {
            if let imageData = NSData(contentsOf : url as URL) {
                image = UIImage(data: imageData as Data)
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string : DemoURL.standford)
    }

}
