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
    var arrayOfTweetDates:AnyObject = []

    @IBOutlet var addButton : UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

         addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "segueToAddView")
//        self.navigationItem.rightBarButtonItem = addButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func viewDidAppear(animated: Bool) {
        self.login()
        var tweetUserDefaultsForCell:NSUserDefaults? = NSUserDefaults.standardUserDefaults()
        if (tweetUserDefaultsForCell?.objectForKey("TWEETTEXTS") != nil) {
         arrayOfTweetTexts = tweetUserDefaultsForCell!.objectForKey("TWEETTEXTS")!
         arrayOfTweetDates = tweetUserDefaultsForCell!.objectForKey("TWEETDATES")!
        self.tableView.reloadData()
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = arrayOfTweetDates[indexPath.row] as! NSDate
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }
    
    func segueToAddView() {
        println("segueToAddView is called")
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTweetTexts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

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
            //arrayOfTweetDates.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
            println("Segue is failed \(userSession.userName)")
            //self.label.text = "Signed as \(userSession.userName)"
            println("Signed as \(userSession.userName)")
            //userID = userSession.userID
        }else{
            self.performSegueWithIdentifier("toLogin", sender: nil)
            println("Segue is successful ")
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



}

