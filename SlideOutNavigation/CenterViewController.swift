//
//  CenterViewController.swift
//  AdsForCharity
//


import UIKit

class CenterViewController: UIViewController {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var userRaisedLabel: UILabel!
    
    var currentImage: Int?
    
    var timer: NSTimer?
    var timerStart: NSDate?
    
    var timer2: dispatch_source_t?
    
//    var alert: UIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentImage = 0
//        alert = UIAlertView()
//        alert!.title = "+0.10"
//        alert!.addButtonWithTitle("Ok")

        self.showAds()
//        self.showTotalRaised()
    }
    
//    func startTimer2() {
//        let queue = dispatch_queue_create("com.domain.app.timer", nil)
//        timer2 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
//        dispatch_source_set_timer(timer2, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 1 * NSEC_PER_SEC); // every 5 seconds, with leeway of 1 second
//            dispatch_source_set_event_handler(timer2) {
//                // do whatever you want here
//                self.nextAd()
//            }
//        dispatch_resume(timer2)
//    }
//    
//    func stopTimer2() {
//        dispatch_source_cancel(timer2)
//        timer2 = nil
//    }
    
    func showAds() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            let url = NSURL(string: ADS[self.currentImage!].image_url)
            let data = NSData(contentsOfURL: url!)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.imageView.image = UIImage(data: data!)
                self.currentImage = self.currentImage! + 1 < ADS.count ? self.currentImage! + 1 : 0
                self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("showAds"), userInfo: nil, repeats: false)
            })
        })
    }
    
//    not working 
    func pauseAds() {
        self.timer = nil
    }
    
    func showTotalRaised() {
//        println("show total raised - " + FIRE_BASE_URL + "/total-raised")
        var fireBaseRef = Firebase(url:FIRE_BASE_URL + "/total-raised")
        var snapshot = fireBaseRef.observeEventType(.Value, withBlock: { snapshot in
            print("total-raised: ")
            println(snapshot.value)
        })
        print("result: ")
        println(snapshot.value)
    }

}
