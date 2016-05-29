//
//  DetailViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/15.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//
//14/12/2015 I did not do work


import UIKit
import TwitterKit

class DetailViewController: UIViewController,UITextViewDelegate {

//    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var tweetButton : UIButton?
    @IBOutlet var tweetLabel : UILabel!
//    @IBOutlet var tweetDatePicker : UIDatePicker!
//    @IBOutlet var repeatSwitch : UISwitch!
//    @IBOutlet var daysSegment : UISegmentedControl!
    


    var detailItem: AnyObject?
    
    var tweetText: String!
    
    var numberOfTweet : Int!
    
    func tweetTextConfigureView() {
        
        if let textOfTweet : String! = self.tweetText{
            print("\(tweetText)")
            tweetLabel.clipsToBounds = true
            tweetLabel.layer.cornerRadius = 5
            let label : UILabel! = UILabel()
            label.frame = CGRectMake(20, 93,335,0)
            label.text = textOfTweet
            label.numberOfLines = 0
            label.sizeToFit()
            self.view.addSubview(label)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tweetTextConfigureView()
        //let defaults = NSUserDefaults.standardUserDefaults()
        print("text -> \(tweetText!)")
        //print("NumOfTimes -> \(numberOfTweet + 1)")
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
//        tweetDatePicker.datePickerMode = UIDatePickerMode.DateAndTime
//        tweetDatePicker.minimumDate = NSDate()
//        tweetDatePicker.maximumDate = NSDate(timeIntervalSinceNow: 365 * 24 * 60 * 60)
//        
//        repeatSwitch.on = false
//        repeatSwitch.frame.origin.x = self.view.center.x
//        
//        daysSegment.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cmposeTweet(){
        let endPoint = "https://api.twitter.com/1.1/statuses/update.json"
        let parameters = ["status":"\(tweetText!)"]
        let client : TWTRAPIClient = Twitter.sharedInstance().APIClient
        let request : NSURLRequest = client.URLRequestWithMethod("POST", URL: endPoint, parameters: parameters, error: nil)
        
        client.sendTwitterRequest(request, completion:{ (TWTRNetworkCompletion) -> Void in
            // 送信完了
        })
        print("tweeted\(request)")
    }
    
}

