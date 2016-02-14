//
//  TERMViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2016/02/14.
//  Copyright © 2016年 Kotaro Suto. All rights reserved.
//

import UIKit

class TERMViewController: UIViewController {
    
    @IBOutlet var textView : UITextView?
    @IBOutlet var agreeButton : UIButton?
    
    var hasAgreed : Bool = true
    
    //利用規約を変更したら、その時のアップデート時だけtrueにする
    var didUpdateTerm : Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(__FUNCTION__,__FILE__)
        textView?.layer.masksToBounds = true
        textView?.layer.cornerRadius = 5
        
        agreeButton?.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
            let path_file_name = NSBundle.mainBundle().pathForResource("BOTMAKER-TermOfService", ofType: "txt")
            do {
                
                let text = try NSString( contentsOfFile: path_file_name!, encoding: NSUTF8StringEncoding )
                print( text )
                textView?.text = text as String 
                
            } catch {
                //エラー処理
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func agree() {
        let firstRundateDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        firstRundateDefaults.setObject(NSDate(), forKey: "firstRunDate")
        firstRundateDefaults.synchronize()
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
