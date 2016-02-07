//
//  LoginViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/21.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    let Colors = AppColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginView is appeared")
        let master = MasterViewController()
        if master.isLogin() {
            self.setLogoutButton()
        }else if !master.isLogin() {
            self.setLoginButton()
        }else{
            setLogoutButton()
        }
        //        let loginButton = TWTRLogInButton(logInCompletion: {
        //            session, error in
        //            let userSession = session
        //            if session != nil {
        //                let userData : NSData = NSKeyedArchiver.archivedDataWithRootObject(userSession!);
        //                print(session!.userName)
        //                // ログイン成功したら遷移する
        //                let loginDefaults = NSUserDefaults.standardUserDefaults()
        //                loginDefaults.setObject(userData, forKey: "USERSESSION")
        //                loginDefaults.synchronize()
        //                self.dismissViewControllerAnimated(false, completion: nil)
        //            } else {
        //                print(error!.localizedDescription)
        //            }
        //        })
        //        loginButton.center = self.view.center
        //        self.view.addSubview(loginButton)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLoginButton() {
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            let userSession = session
            if session != nil {
                let userData : NSData = NSKeyedArchiver.archivedDataWithRootObject(userSession!);
                print(session!.userName)
                // ログイン成功したら遷移する
                let loginDefaults = NSUserDefaults.standardUserDefaults()
                loginDefaults.setObject(userData, forKey: "USERSESSION")
                loginDefaults.synchronize()
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                print(error!.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    func setLogoutButton() {
        let logoutButton = UIButton()
        logoutButton.setTitle("Twitterからログアウト", forState:.Normal)
        logoutButton.setTitleColor(UIColor.whiteColor(), forState:.Normal)
        logoutButton.layer.cornerRadius = 5
        logoutButton.frame = CGRectMake(0, 0, self.view.frame.width - 60, 40)
        logoutButton.backgroundColor = Colors.Twitterblue
        logoutButton.center = self.view.center
        logoutButton.addTarget(self, action:"logout", forControlEvents:.TouchUpInside)
        self.view.addSubview(logoutButton)
        
        let cacelButton = UIButton()
        cacelButton.setTitle("×", forState:.Normal)
        cacelButton.setTitleColor(UIColor.blackColor(), forState:.Normal)
        cacelButton.frame = CGRectMake(15,20,30,30)
        cacelButton.layer.cornerRadius = 10
        cacelButton.backgroundColor = UIColor.whiteColor()
        cacelButton.addTarget(self, action:"cancel", forControlEvents:.TouchUpInside)
        self.view.addSubview(cacelButton)
    }
    
    func logout() {
        let logoutDefaults = NSUserDefaults.standardUserDefaults()
        let userSessionStore = Twitter.sharedInstance().sessionStore
        let userSession = NSKeyedUnarchiver.unarchiveObjectWithData(logoutDefaults.objectForKey("USERSESSION") as! NSData) as! TWTRSession
        let userID = userSession.userID
        
        if userID != "" {
            userSessionStore.logOutUserID(userID)
            logoutDefaults.removeObjectForKey("USERSESSION")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
}
