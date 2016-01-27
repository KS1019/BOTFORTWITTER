//
//  DetailViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/15.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//
//14/12/2015 I did not do work


import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {

//    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var tweetTextField : UITextField!
//    @IBOutlet var tweetDatePicker : UIDatePicker!
//    @IBOutlet var repeatSwitch : UISwitch!
//    @IBOutlet var daysSegment : UISegmentedControl!
    


    var detailItem: AnyObject? {
        //Tweet Time
        didSet {
            // Update the view.
            //self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let textField = self.tweetTextField {
                textField.text = detail.description
            }
        }
    }
    
    var tweetText: String? {
        didSet{
            self.tweetTextConfigureView()
        }
    }
    
    func tweetTextConfigureView() {
        
        if let textOfTweet = self.tweetText{
            if let textField  = self.tweetTextField {
                textField.text = textOfTweet
                print("@@")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        tweetTextField.enabled = false
        self.tweetTextConfigureView()
        tweetTextField.delegate = self
        print("\(tweetText)")
        
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


}

