//
//  AddViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/18.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITextViewDelegate {
    
    
    
    @IBOutlet var tweetTextView : UITextView!
    @IBOutlet var labelOfCountOfText : UILabel!
    @IBOutlet var datePickerOfTweet : UIDatePicker!
    
    var tweetDate : String!
    
    var tweetTexts = [String]()
    //var tweetDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.layer.masksToBounds = true
        tweetTextView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        //TextFieldを生成

        
        //ボタンを追加するためのViewを生成します。
        let myKeyboard = UIView(frame: CGRectMake(0, 0, 320, 40))
        myKeyboard.backgroundColor = UIColor.lightGrayColor()
        
        //完了ボタンの生成
        let myButton = UIButton(frame: CGRectMake(300, 5, 70, 30))
        myButton.backgroundColor = UIColor.darkGrayColor()
        myButton.setTitle("完了", forState: .Normal)
        myButton.layer.cornerRadius = 2.0
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        //Viewに完了ボタンを追加する。
        myKeyboard.addSubview(myButton)
        
        //ViewをFieldに設定する
        tweetTextView.inputAccessoryView = myKeyboard
        tweetTextView.delegate = self
        
        //myTextFieldを追加する 
        //self.view.addSubview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func done(){
        if (tweetTextView.text != nil) {
            let tweetUserDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            tweetTexts = tweetUserDefaults.objectForKey("TWEETTEXTS") as! [String]
            //tweetDates = tweetUserDefaults.objectForKey("TWEETDATES") as! [String]
            
//            let myDateFormatter: NSDateFormatter = NSDateFormatter()
//            myDateFormatter.dateFormat = "hh:mm"
//            let mySelectedDate: NSString = myDateFormatter.stringFromDate(datePickerOfTweet.date)
//            tweetDate = mySelectedDate as String
            
//            print("tweetTexts -> \(tweetTexts) tweetDates -> \(tweetDates)")
            tweetTexts.append(tweetTextView.text)
            //tweetDates.append(tweetDate)
            print("tweetTexts -> \(tweetTexts)")
            
            tweetUserDefaults.setObject(tweetTexts, forKey:"TWEETTEXTS")
            //tweetUserDefaults.setObject(tweetDates, forKey:"TWEETDATES")
            tweetUserDefaults.synchronize()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: -TextView
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing : \(textView.text)");
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("textViewShouldEndEditing : \(textView.text)");
        
        //文字数制限
        let maxLength : Int = 140
        
        let str = textView.text
        if "\(str)".characters.count <= maxLength {
            return true
        }else{
            
            return false
            
        }
        
    }
    
    func textViewDidChange(textView: UITextView) {
        print("textViewDidChange : \(textView.text)");
        
        //文字数制限
        let maxLength : Int = 140
        
        let str = textView.text
        
        let countOfCharacter : Int = maxLength - "\(str)".characters.count
        
        if countOfCharacter >= 0 {
            labelOfCountOfText.textColor = UIColor.blueColor()
            labelOfCountOfText.text = String(countOfCharacter)
        }else if countOfCharacter < 0 {
            labelOfCountOfText.textColor = UIColor.redColor()
            labelOfCountOfText.text = String(countOfCharacter)
        }
        
    }
    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
//        replacementText text: String) -> Bool {
//            if text == "\n" {
//                textView.resignFirstResponder() //キーボードを閉じる
//                return false
//            }
//            return true
//    }
    
    
    //ボタンを押すとキーボードが下がるメソッド
    func onClickMyButton (sender: UIButton) {
        self.view.endEditing(true)
    }
    //改行押すとキーボードが下がるメソッド
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
