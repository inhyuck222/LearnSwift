//
//  ViewController.swift
//  Facelt
//
//  Created by 임인혁 on 2018. 1. 24..
//  Copyright © 2018년 inorv. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Frown){
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            ))
            
            addHappierSwipeGestureRecognizer()
            
            addSadderSwipeGestureRecognizer()
            
            updateUI()
        }
    }
    
    func addHappierSwipeGestureRecognizer(){
        let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(FaceViewController.increaseHappiness)
        )
        happierSwipeGestureRecognizer.direction = .up
        faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
    }
    
    func addSadderSwipeGestureRecognizer(){
        let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(FaceViewController.decreaseHappiness)
        )
        sadderSwipeGestureRecognizer.direction = .down
        faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes{
            case .Open : expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting : expression.eyes = .Squinting
            }
        }
    }
    
    @objc
    func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc
    func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures = [
        FacialExpression.Mouth.Frown : -1.0,
        .Grin : -0.5,
        .Neutral : 0.0,
        .Smirk : 0.5,
        .Smile : 1.0
    ]
    
    private var eyeBrowTilts = [
        FacialExpression.EyeBrows.Furrowed : -0.5,
        .Normal : 0.0,
        .Relaxed : 0.5
    ]
    
    private func updateUI(){
        switch expression.eyes{
        case .Open : faceView.eyesOpen = true
        case .Closed : faceView.eyesOpen = false
        case .Squinting : faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
    
}

