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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginView is appeared")
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
                self.dismissViewControllerAnimated(false, completion: nil)
            } else {
                print(error!.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
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
