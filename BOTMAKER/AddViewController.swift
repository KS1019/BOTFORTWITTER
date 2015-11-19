//
//  AddViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/18.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet var doneButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func done(){
        self.dismissViewControllerAnimated(true, completion: nil)
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
