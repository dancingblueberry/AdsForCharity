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
    ad(image_url: "http://assets.worldwildlife.org/photos/144/images/original/Giant_Panda_Hero_image_(c)_Michel_Gunther_WWF_Canon.jpg?1345515244", company: "unisef"),
    ad(image_url: "http://static.guim.co.uk/sys-images/Guardian/Pix/audio/video/2012/9/17/1347907861151/Giant-panda-Mei-Xiang-tak-010.jpg", company: "boo")
]
