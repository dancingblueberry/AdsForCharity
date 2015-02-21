//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
class Animal {
    
    let title: String
    let image: UIImage?
 
    init(title: String, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func allCats() -> Array<Animal> {
        return [ Animal(title: "Menu", image: UIImage(named: "ID-100113060.jpg")),
                 Animal(title: "Account", image: UIImage(named: "ID-10022760.jpg")),
                 Animal(title: "About", image: UIImage(named: "ID-10091065.jpg")) ]
    }

}