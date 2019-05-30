//
//  ViewController.swift
//  質數測試
//
//  Created by WADE on 2019/4/9.
//  Copyright © 2019 WADE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputNumberText: UITextField!
    
    
    @IBOutlet weak var outputNumberLable: UILabel!
    
    
    @IBAction func checkBtn(_ sender: UIButton) {
        
        if let inputText = inputNumberText.text
        {
            if  let inputNumber = Int(inputText){
              outputNumberLable.text =  checkNumber(textNumber: inputNumber)
                outputNumberLable.isHidden = false
            }
        }
        
        
        
        inputNumberText.text = ""
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputNumberText.becomeFirstResponder()
        
        
    }

    func checkNumber(textNumber:Int)->String{
        var trueNumber : Bool? = true
        if textNumber <= 0{
            trueNumber = nil
        }
        else if textNumber == 1{
            trueNumber = false
        }
        else
        {
            for num in 2..<textNumber{
                if textNumber % num==0
                {
                    trueNumber = false
                    break
                }
            }
        }
        if trueNumber == true{
            return "\(textNumber)是質數"
        }
        else if trueNumber == false{
            return "\(textNumber)不是質數"
        }
        else{
            return "請輸入比0大得數字"
        }
        
    }
}

