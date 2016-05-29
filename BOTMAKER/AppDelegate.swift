//
//  AppDelegate.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/15.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Twitter.self])
        //バックグラウンドの設定
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        let termView = TERMViewController()
        let firstrunDateDefaults = NSUserDefaults.standardUserDefaults()
        if termView.didUpdateTerm == true {
            if firstrunDateDefaults.objectForKey("didChecked") == nil {
                firstrunDateDefaults.removeObjectForKey("firstRunDate")
                firstrunDateDefaults.setObject(NSDate(), forKey:"didChecked")
                firstrunDateDefaults.synchronize()
                print("アップデート後、初回起動だよ")
            }
        }
        
        if isFirstRun() {
            //初回起動
            termView.hasAgreed = false
            firstrunDateDefaults.setObject(termView.hasAgreed, forKey: "hasAgreed")
            firstrunDateDefaults.synchronize()
            print("初回起動だよ")
        }else{
            termView.hasAgreed = true
            firstrunDateDefaults.setObject(termView.hasAgreed, forKey: "hasAgreed")
            firstrunDateDefaults.synchronize()
            print("初回起動じゃないよ -> \(termView.hasAgreed)")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        let tweetsUserDefaults = NSUserDefaults.standardUserDefaults()
        //バックグラウンドでの処理
        let now = NSDate()
        
        let nowFormatter = NSDateFormatter()
        nowFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        nowFormatter.dateFormat = "HH"
        
        let dayFormatter = NSDateFormatter()
        dayFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dayFormatter.dateFormat = "yyyy/MM/dd"
        
        let string = nowFormatter.stringFromDate(now)
        
        print("now -> ",string)
        completionHandler(UIBackgroundFetchResult.NewData)
        
        let tweets = tweetsUserDefaults.objectForKey("TWEETTEXTS") as! [String]
        print("tweets -> \(tweets)")
        if tweets.count > 0 {
            let countOfTweets = tweets.count
            let randomIndex = Int(arc4random_uniform(UInt32(countOfTweets)))
//            for num in 0...countOfTweets - 1 {
//                var sum = 1 + num
//                print("\(sum)回目だよ")
//                let numbersOfTweets = tweetsUserDefaults.objectForKey("NUMOFTIMESOFTWEET")
//                let numOfTweet : Int = (numbersOfTweets![num] as? Int)!
                let tweet : String = tweets[randomIndex]
                
//                var logsOfTweet : [NSDate] = [NSDate]()
//                if tweetsUserDefaults.objectForKey(tweet) != nil {
//                    logsOfTweet = tweetsUserDefaults.objectForKey(tweet) as! [NSDate]
//                    print("logsOfTweet -> \(logsOfTweet)\n\(tweet)")
//                    
//                }
//                var lastLog : NSDate!
//                if logsOfTweet.last == nil {
//                    print("最後は今")
//                    lastLog = now
//                }else{
//                    print("最後は最後")
//                    lastLog = logsOfTweet.last
//                }
//                print("lastLog -> \(lastLog)")
//                let stringLastLog = dayFormatter.stringFromDate(lastLog)
//                let stringNow = dayFormatter.stringFromDate(now)
//                
//                if stringLastLog != stringNow {
//                    print("日付変わってるよ")
//                    logsOfTweet.removeAll()
//                    logsOfTweet.append(now)
//                }
                
//                let timeLastLog : String = nowFormatter.stringFromDate(lastLog!)
//                let timeNow : String = nowFormatter.stringFromDate(now)
//                print("最後のログ -> \(timeLastLog) 今のログ -> \(timeNow)")
                
                //if Int(timeLastLog)! + 1 <= Int(timeNow)! {
                
//                if logsOfTweet.count <= numOfTweet {
//                    print("logsOfTweet.count -> \(logsOfTweet.count)")
//                    logsOfTweet.append(now)
//                    //TODO: Fix -> keyがtweetだとかぶる可能性がある
//                    //TODO: Fix -> 1日で絶対に三回以上呼ばれる前提になってる。
////                    tweetsUserDefaults.setObject(logsOfTweet, forKey: tweet)
////                    print("\(tweets,num)")
                    let endPoint = "https://api.twitter.com/1.1/statuses/update.json"
                    let parameters = ["status":"\(tweet)"]
                    let client : TWTRAPIClient = Twitter.sharedInstance().APIClient
                    let request : NSURLRequest = client.URLRequestWithMethod("POST", URL: endPoint, parameters: parameters, error: nil)
                    client.sendTwitterRequest(request, completion:{ (TWTRNetworkCompletion) -> Void in
                        // 送信完了
                        print("送信完了")
                    })
//
                    print("tweeted\(request)")
                    print("tweet : \(parameters)")
//                }
                
            
            
        }
        
    }
    
    func isFirstRun() -> Bool {
        let FirstRunDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if (FirstRunDefaults.objectForKey("firstRunDate") != nil) {
            return false
        }else{
            return true

        }
    }


}

