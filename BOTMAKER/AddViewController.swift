//
//  AddViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/18.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITextViewDelegate{

    

    @IBOutlet var tweetTextView : UITextView!
    
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
    
    // MARK: -TextView
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        println("textViewShouldBeginEditing : \(textView.text)");
        return true
    }

    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        println("textViewShouldEndEditing : \(textView.text)");
        
        //文字数制限
        let maxLength : Int = 140
        
        var str = textView.text
        if count("\(str)") <= maxLength {
            return true
        }else{
            tweetTextView.editable = false
        
        return false
   
        }
        
    }
    
    func textViewDidChange(textView: UITextView) {
        println("textViewDidChange : \(textView.text)");
        
        //文字数制限
        let maxLength : Int = 140
        
        var str = textView.text
        if count("\(str)") <= maxLength {

        }else{
            tweetTextView.editable = false
            
    
        }
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
