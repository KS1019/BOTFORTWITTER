//
//  TERMViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2016/02/14.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class TERMViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(__FUNCTION__,__FILE__)

        // Do any additional setup after loading the view.
        
//        if let filePath = NSBundle.mainBundle().pathForResource("BOTMAKER-TermOfService", ofType: "txt"){
//            var error:NSError?
//            let userPolicy = NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding,erorr:nil)
//                NSLog("\(userPolicy)") as String
//            
//        }
        
        let file_name = "BOTMAKER-TermOfService"
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true ).first {
            
            let path_file_name = NSBundle.mainBundle().pathForResource("BOTMAKER-TermOfService", ofType: "txt")
            do {
                
                let text = try NSString( contentsOfFile: path_file_name!, encoding: NSUTF8StringEncoding )
                print( text )
                
            } catch {
                //エラー処理
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
