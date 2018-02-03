//
//  DemoURL.swift
//  Cassini
//
//  Created by 임인혁 on 2018. 2. 3..
//  Copyright © 2018년 inorv. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let standford = "http://gyuchan.github.io/hansung/assets/img/slider/1.jpg"
    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(imageName : String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""]{
            return NSURL(string: urlString)
        } else {
            return nil
        }
    }
}
