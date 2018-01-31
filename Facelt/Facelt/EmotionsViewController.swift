//
//  EmotionsViewController.swift
//  Facelt
//
//  Created by 임인혁 on 2018. 1. 30..
//  Copyright © 2018년 inorv. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    var emotinalFaces : Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smirk),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        
        if let navigationController = destinationViewController as? UINavigationController{
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotinalFaces[identifier]{
                    faceViewController.expression = expression
                    if let sedingButton = sender as? UIButton{
                        faceViewController.navigationItem.title = sedingButton.currentTitle
                    }
                }
            }
        }
    }

}
