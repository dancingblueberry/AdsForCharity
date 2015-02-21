//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func collapseSidePanels()
}

class CenterViewController: UIViewController, SidePanelViewControllerDelegate {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var userRaisedLabel: UILabel!
    
    var timer: NSTimer?
    var timerStart: NSDate?
    var delegate: CenterViewControllerDelegate?
    var currentImage: Int?

    // MARK: Button actions
    
    @IBAction func menuTapped(sender: AnyObject) {
        delegate?.toggleLeftPanel?()
    }
    
    func menuItemSelected(menuItem: MenuItem) {
//        imageView.image = menuItem.image
//        titleLabel.text = menuItem.title
        
        delegate?.collapseSidePanels?()
    }
    
    func startTimer() {
        self.currentImage = 0
        
        // get current system time
        self.timerStart = NSDate()
        
        // start the timer
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("nextAd"), userInfo: nil, repeats: true)
    }
    
    func nextAd() {
        let url = NSURL(string: ADS[currentImage!].image_url)
        let data = NSData(contentsOfURL: url!)
        imageView.image = UIImage(data: data!)
//        titleLabel.text = "Ad: " + toString(currentImage)
        currentImage = currentImage! + 1 < ADS.count ? currentImage! + 1 : 0
    }
    
    func showUserRaised() {
        var fireBaseRef = Firebase(url:FIRE_BASE_URL + "/user")
        fireBaseRef.observeEventType(.Value, withBlock: { snapshot in
            print("user-raised: ")
//            println(snapshot.value)
            let result = snapshot.value as? String
            print(result)
//            self.userRaisedLabel.text = result
            //                let raised = snapshot.value.objectForKey("raised") as? String
            //                println(raised)
        })
        //  println(snapshot.value)
        //  userRaisedLabel.text = toString(snapshot)
        //  fireBaseRef.valueForKey("raised")
    }
    
    func showTotalRaised() {
        var fireBaseRef = Firebase(url:FIRE_BASE_URL + "/total-raised")
        fireBaseRef.observeEventType(.Value,
            withBlock: {
                snapshot in
                print("total-raised: ")
                println(snapshot.value)
                //                let raised = snapshot.value.objectForKey("raised") as? String
                //                println(raised)
        })
        //        println(snapshot.value)
        //  yourRaisedTextView.text = String(snapshot)
        //  fireBaseRef.valueForKey("raised")
    }

}
