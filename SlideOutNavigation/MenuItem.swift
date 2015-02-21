//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
class MenuItem {
    
    let title: String
    let image: UIImage?
 
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func allMenuItems() -> Array<MenuItem> {
        return [ MenuItem(title: "Menu", image: UIImage(named: "ID-100113060.jpg")),
                 MenuItem(title: "Account", image: UIImage(named: "ID-10022760.jpg")),
                 MenuItem(title: "About", image: UIImage(named: "ID-10091065.jpg")) ]
    }

}