//
//  ViewController.swift
//  倒數計時器
//
//  Created by Cheetah on 2019/2/15.
//  Copyright © 2019年 Cheetah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer : Timer?
    var countDownTime : Int = 0
    var countSec : Int = 0

    
    

    
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    
    @IBOutlet weak var mystepper: UIStepper!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myDate: UIDatePicker!
    
    @IBOutlet weak var myImage: UIImageView!
    

    
    
    
    
    @IBAction func startBtn(_ sender: UIButton) {
        
        start.isEnabled = false
        stop.isEnabled = true
        myDate.isEnabled = false
        myLabel.text = ""
        mystepper.isEnabled = false
        countSec = Int(mystepper.value)
        countDownTime = Int(myDate.countDownDuration) + countSec
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.countDown), userInfo: nil, repeats: true)
      // myLabel.text = "剩下\(countDownTime)秒"
        
        myLabel.text = "開始計時!"
        //啟動時secLabel消失
        secLabel.text = ""
        
    

     
            }
    
    @objc func countDown(){
        countSec = countSec - 1
        countDownTime = countDownTime - 1
        if countSec == -1{
            if countDownTime < 0{
                myLabel.text = "時間到!"
            stopTimer()
            }else
            {
                countSec = 59
             //   secLabel.text = "\(countSec)"
                myDate.countDownDuration     = TimeInterval(countDownTime)
               myLabel.text = "剩下\(countDownTime)秒"
            }
        }else{
        //   secLabel.text = "\(countSec)"
         myLabel.text = "剩下\(countDownTime)秒"
        }
    }
    
    @IBAction func stepperChange(_ sender: UIStepper) {
        secLabel.text = "\(Int(mystepper.value)) sec"
    }
    
    @IBAction func stopBtn(_ sender: UIButton) {
        stopTimer()
    }
    
  //  func startTimer () {
  //      starting = true
       
    
   // }
    
    
    func stopTimer(){
        // starting = false
        start.isEnabled = true
        stop.isEnabled = false
        myDate.isEnabled = true
        timer?.invalidate()
        timer = nil
        mystepper.value = 0
        mystepper.isEnabled = true
        secLabel.text = "0 sec"
        
    }


    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mystepper.minimumValue = 0
        mystepper.maximumValue = 59
        mystepper.value = 0
        secLabel.text = "0 sec"
        stop.isEnabled = false
        
        
        
        
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

