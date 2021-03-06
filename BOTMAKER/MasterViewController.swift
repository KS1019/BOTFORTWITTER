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
    var arrayOfTweetTextsForTweet:[String] = []
    var arrOfNum : [Int]!
    //var arrayOfTweetDatesForTweet:[String] = []
    @IBOutlet var addButton : UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(__FILE__,__FUNCTION__)
        tableView.layoutMargins = UIEdgeInsetsZero
        //let termView = TERMViewController()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.objectForKey("hasAgreed") as! Bool != true {
            print(__FUNCTION__,"inIF")
            self.segueTermView()
        }
        addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "segueToAddView")
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.login()
        
        let tweetUserDefaultsForCell:NSUserDefaults? = NSUserDefaults.standardUserDefaults()
        tweetUserDefaultsForCell!.addObserver(self, forKeyPath: "TWEETTEXTS", options: NSKeyValueObservingOptions.New, context: nil)
        //tweetUserDefaultsForCell?.addObserver(self, forKeyPath: "TWEETDATES", options: NSKeyValueObservingOptions.New, context: nil)
        let a = tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS")
        print(a)
        let b = tweetUserDefaultsForCell
        print(b)
        
//        let className = NSStringFromClass(.dynamicType).componentsSeparatedByString(".").last! as String
        //        println("\(className)")
        if (tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS") != nil) {
            if tweetUserDefaultsForCell!.objectForKey("NUMOFTIMESOFTWEET") != nil {
                arrOfNum = tweetUserDefaultsForCell!.objectForKey("NUMOFTIMESOFTWEET")! as! [Int]
                arrayOfTweetTexts = tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS")!
                //arrayOfTweetDates = tweetUserDefaultsForCell!.objectForKey("TWEETDATES")!
                self.tableView.reloadData()
                
                print("\(arrayOfTweetTexts,arrOfNum)")
                print("現在値 -> \(tweetUserDefaultsForCell!.objectForKey("NUMOFTIMESOFTWEET")!,tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS") as! [String])")
            }
        }
        tableView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutMargins = UIEdgeInsetsZero
    }
    
    @IBAction func touchedSettings(){
        
        if isLogin() {
            self.performSegueWithIdentifier("toLogin", sender: nil)
        }
        
    }
    
    // MARK: - Segues
    
    func segueTermView() {
        self.performSegueWithIdentifier("toTERMView", sender: nil)
    }
    // TODO: -repair
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let time = arrayOfTweetDates[indexPath.row] // TODO: -repair
                let text : String = arrayOfTweetTexts[indexPath.row] as! String
                //let numOfTweet : Int = arrOfNum[indexPath.row]
                //(segue.destinationViewController as! DetailViewController).detailItem = time
                (segue.destinationViewController as! DetailViewController).tweetText = text
                //(segue.destinationViewController as! DetailViewController).numberOfTweet = numOfTweet
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
        cell.layoutMargins = UIEdgeInsetsZero
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
                //var numberOfTimesOfTweet = arrOfNum
                //print("arrOfNum -> \(arrOfNum)")
                //numberOfTimesOfTweet.removeAtIndex(indexPath.row)
                //print("削除後 -> \(numberOfTimesOfTweet)")
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                let tweetsDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                //tweetsDefaults.setObject(numberOfTimesOfTweet, forKey: "NUMOFTIMESOFTWEET")
                tweetsDefaults.setObject(arrayOfTweetTexts, forKey: "TWEETTEXTS")
                //tweetsDefaults.setObject(arrayOfTweetDates, forKey: "TWEETDATES")
                tweetsDefaults.synchronize()
                
                //print("\(arrayOfTweetTexts,numberOfTimesOfTweet)")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: -Login
    
    func login (){
        let userDefaultOfSession = NSUserDefaults.standardUserDefaults()
        if  self.isLogin() {
            let userSession = NSKeyedUnarchiver.unarchiveObjectWithData(userDefaultOfSession.objectForKey("USERSESSION") as! NSData) as! TWTRSession
            print("It did not segue \(userSession.userName)")
            print("Signed as \(userSession.userName)")
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
    
    
    // MARK: NSUserDefaultsObserver
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("UserDefaults was changed \(object?.objectForKey(keyPath!))")
        arrayOfTweetTextsForTweet = (object?.objectForKey("TWEETTEXTS"))! as! [String]
        //arrayOfTweetDatesForTweet = (object?.objectForKey("TWEETDATES"))! as! [String]
    }
    
    
}

