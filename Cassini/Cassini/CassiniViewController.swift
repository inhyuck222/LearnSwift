//
//  CassiniViewController.swift
//  Cassini
//
//  Created by 임인혁 on 2018. 2. 6..
//  Copyright © 2018년 inorv. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    private struct Storyboard{
        static let ShowImageSegue = "Show Image"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.ShowImageSegue {
            if let imageViewController = segue.destination.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                imageViewController.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                imageViewController.title = imageName
            }
        }
    }

}

extension UIViewController{
    var contentViewController : UIViewController {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController ?? self
        }else {
            return self
        }
    }
}
