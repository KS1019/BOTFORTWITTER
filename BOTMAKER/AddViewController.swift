//
//  AddViewController.swift
//  BOTMAKER
//
//  Created by Kotaro Suto on 2015/11/18.
//  Copyright (c) 2015年 Kotaro Suto. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    
    @IBOutlet var tweetTextView : UITextView!
    @IBOutlet var labelOfCountOfText : UILabel!
    @IBOutlet var pickerOfTweet : UIPickerView!
    @IBOutlet var datePickerOfTweet : UIDatePicker!
    
    var arrayOfQuestion : [String] = ["1日に1回","1日に2回","1日に3回"]
    
    
    var tweetDate : String!
    
    var tweetTexts : [String]! = [String]()
    var arrOfNumOfTimesOfTweet : [Int]! = [Int]()
    //var tweetDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.layer.masksToBounds = true
        tweetTextView.layer.cornerRadius = 5
        
        pickerOfTweet.delegate = self
        pickerOfTweet.dataSource = self
        
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
            let tweetUserDefaults : NSUserDefaults! = NSUserDefaults.standardUserDefaults()
            tweetTexts = tweetUserDefaults.objectForKey("TWEETTEXTS") as! [String]!
            //tweetDates = tweetUserDefaults.objectForKey("TWEETDATES") as! [String]
            
            arrOfNumOfTimesOfTweet = tweetUserDefaults.objectForKey("NUMOFTIMESOFTWEET") as! [Int]!
            if arrOfNumOfTimesOfTweet == nil {
                print("パッパラ〜")
                arrOfNumOfTimesOfTweet = [Int]()
            }
            
            if tweetTexts == nil {
                print("ペッペペ〜")
                tweetTexts = [String]()
            }
            let numberOfTimesOfTweet : Int! = pickerOfTweet.selectedRowInComponent(0) as Int!
            arrOfNumOfTimesOfTweet.append(numberOfTimesOfTweet)
            tweetUserDefaults.setObject(arrOfNumOfTimesOfTweet, forKey:"NUMOFTIMESOFTWEET")
            
            
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
    
    
    
    //ボタンを押すとキーボードが下がるメソッド
    func onClickMyButton (sender: UIButton) {
        self.view.endEditing(true)
    }
    //改行押すとキーボードが下がるメソッド
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: -UIPickerViewDelegate
    
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示個数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfQuestion.count
    }
    
    //表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfQuestion[row] as String
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("列:")
        print("値:")
    }
    
    
    func convertString(string: String) -> String {
        let data = string.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        return NSString(data: data!, encoding: NSASCIIStringEncoding) as! String
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
