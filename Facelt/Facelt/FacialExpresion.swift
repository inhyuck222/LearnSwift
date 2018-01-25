//
//  FacialExpresion.swift
//  Facelt
//
//  Created by 임인혁 on 2018. 1. 25..
//  Copyright © 2018년 inorv. All rights reserved.
//

import Foundation

struct FacialExpression{
    enum Eye : Int{
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows : Int{
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth : Int{
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes : Eye
    var eyeBrows : EyeBrows
    var mouth : Mouth
}
