//
//  ImageViewController.swift
//  Cassini
//
//  Created by 임인혁 on 2018. 2. 3..
//  Copyright © 2018년 inorv. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
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
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
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
    }

}
