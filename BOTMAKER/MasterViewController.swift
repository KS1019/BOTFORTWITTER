//
//  MasterViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/15.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit
import TwitterKit

class MasterViewController: UITableViewController {

    var objects = [AnyObject]()
    var arrayOfTweetTexts:AnyObject = []
    //var arrayOfTweetDates:AnyObject = []
    //var timer : NSTimer?
    var arrayOfTweetTextsForTweet:[String] = []
    //var arrayOfTweetDatesForTweet:[String] = []

    @IBOutlet var addButton : UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "checkTiming", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "segueToAddView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func viewDidAppear(animated: Bool) {
        self.login()
        
        let tweetUserDefaultsForCell:NSUserDefaults? = NSUserDefaults.standardUserDefaults()
        tweetUserDefaultsForCell?.addObserver(self, forKeyPath: "TWEETTEXTS", options: NSKeyValueObservingOptions.New, context: nil)
        //tweetUserDefaultsForCell?.addObserver(self, forKeyPath: "TWEETDATES", options: NSKeyValueObservingOptions.New, context: nil)
        
        if (tweetUserDefaultsForCell?.objectForKey("TWEETTEXTS") != nil) {
            
         arrayOfTweetTexts = tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS")!
         //arrayOfTweetDates = tweetUserDefaultsForCell!.objectForKey("TWEETDATES")!
        self.tableView.reloadData()
            
        }
    }

    // MARK: - Segues
// TODO: -repair
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let time = arrayOfTweetDates[indexPath.row] // TODO: -repair
                let text : String = arrayOfTweetTexts[indexPath.row] as! String
            //(segue.destinationViewController as! DetailViewController).detailItem = time
            (segue.destinationViewController as! DetailViewController).tweetText = text
            }
        }
    }
    
    func segueToAddView() {
        print("segueToAddView is called")
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTweetTexts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        let object = arrayOfTweetTexts[indexPath.row] as! String
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if var tweetTextArr = arrayOfTweetTexts as? Array<AnyObject>{
                tweetTextArr.removeAtIndex(indexPath.row)
                arrayOfTweetTexts = tweetTextArr
//                var tweetDatesArr = arrayOfTweetDates as? Array<AnyObject>
//                tweetDatesArr?.removeAtIndex(indexPath.row)
//                arrayOfTweetDates = tweetDatesArr!
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                let tweetsDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                tweetsDefaults.setObject(arrayOfTweetTexts, forKey: "TWEETTEXTS")
                //tweetsDefaults.setObject(arrayOfTweetDates, forKey: "TWEETDATES")
                tweetsDefaults.synchronize()
                
                print("\(arrayOfTweetTexts)")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: -Login
    
    func login (){
        //        let sessionStore = Twitter.sharedInstance().sessionStore
        //        let lastSession = sessionStore.session
        let userDefaultOfSession = NSUserDefaults.standardUserDefaults()
        
        
        if  self.isLogin() {
            let userSession = NSKeyedUnarchiver.unarchiveObjectWithData(userDefaultOfSession.objectForKey("USERSESSION") as! NSData) as! TWTRSession
            print("It did not segue \(userSession.userName)")
            //self.label.text = "Signed as \(userSession.userName)"
            print("Signed as \(userSession.userName)")
            //userID = userSession.userID
        }else{
            self.performSegueWithIdentifier("toLogin", sender: nil)
            print("Segue is success")
        }
        
        
    }
    
    func isLogin() -> Bool{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let loginStatus: AnyObject? = userDefaults.objectForKey("USERSESSION")
        if loginStatus != nil {
            return true
            
        }else{
            return false
        }
    }

    // TODO: I have to fix name of variable
    

    // MARK: NSUserDefaultsObserver
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("UserDefaults was changed \(object?.objectForKey(keyPath!))")
        arrayOfTweetTextsForTweet = (object?.objectForKey("TWEETTEXTS"))! as! [String]
        //arrayOfTweetDatesForTweet = (object?.objectForKey("TWEETDATES"))! as! [String]
    }
    
    // MARK: NSTimer
//    func checkTiming(){
//        print("checking Timing\(NSDate())")
//        let timeNow = NSDate()
//        
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "hh:mm"
//        let string:String = formatter.stringFromDate(timeNow)
//        
//        let index = arrayOfTweetDatesForTweet.indexOf(string)
//        
//        if index != nil {
//            let tweetText = arrayOfTweetTextsForTweet[index!]
//            print("Tweeted\(tweetText,timeNow)")
//        }
//    }

}

