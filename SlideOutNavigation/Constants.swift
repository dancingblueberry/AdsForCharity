//
//  constants.swift
//  SlideOutNavigation
//
//  Created by Leia on 2/21/15.
//  Copyright (c) 2015 James Frost. All rights reserved.
//

import Foundation

let FIRE_BASE_URL = "https://burning-fire-485.firebaseio.com"

class ad {
    var image_url: String
    var company: String
    
    init(image_url: String, company: String) {
        self.image_url = image_url
        self.company = company
    }
}

let ADS: Array<ad> = [
    ad(image_url: "http://www.petyourdog.com/uploads/articles/17-6.jpg", company: "unisef"),
    ad(image_url: "https://www.petfinder.com/wp-content/uploads/2012/11/122163343-conditioning-dog-loud-noises-632x475.jpg", company: "boo"),
    ad(image_url: "http://shakacity.com/sites/default/files/dog_0.jpg", company: "smokey"),
    ad(image_url: "http://images.social-first.net/files/ikwiz/dog-breed-dog-breed-pictures1.jpg", company: "tenten")
]
