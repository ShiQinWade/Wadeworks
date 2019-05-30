//
//  ViewController.swift
//  計算機
//
//  Created by Cheetah on 2019/1/30.
//  Copyright © 2019年 Cheetah. All rights reserved.
//

import UIKit

//none沒有運算



class ViewController: UIViewController {

    var btnTxt = ""
    
    var number1 : Double = 0
    
    var number2 : Double = 0
    
    var ans : Double = 0
    
    //是否運算中
    var numberclick: Bool = false
    
    @IBOutlet weak var myLabel: UILabel!
    

    var getnumber : Double{
        
        get
        {
            
            return Double(myLabel.text!)!
        
        }
        
        
        set
        {
            
            myLabel.text = "\(newValue)"
            
            numberclick = false
        
        }
    
    
    }

    
    
    

    
    
    @IBAction func clear(_ sender: UIButton) {
        //回歸初始值，清除畫面
      
       
        ans = 0
       
        number1 = 0
       
        number2 = 0
       
        myLabel.text = "\(ans)"
        
        numberclick = false
        
        //文字回歸為０，變數回歸初始值
    }
    @IBOutlet var touch7Btn: [UIButton]!
    
    
    @IBAction func touch7Btn(_ sender: UIButton) {
        
        // currentTitle直接顯示案件內容
        
        //按鈕tag屬性，按鈕0 =Tag 1 ,按鈕1=Tag 2,按鈕2=Tag 3....以此類推
        
        var numbers = sender.currentTitle!
        
        if numberclick,myLabel.text != ""{
            
            myLabel.text = myLabel.text! + numbers
            
            print("\(myLabel.text)")
       
        }
        
        else
        
        {
            if numbers != "0"{
                
                
                myLabel.text = numbers
                
                numberclick = true
                
                print(myLabel.text)
                
            }
            
            else
            {
                myLabel.text = "0"
                
                print(myLabel.text)
            }
        
        }


    }
    
    @IBAction func operation(_ sender: UIButton) {
        

            btnTxt = sender.currentTitle!
        
            print(btnTxt)
        
            numberclick = false
        
            number1 = getnumber
        


        
    }
    
    func Cal () {
    
        if btnTxt == "+"
        {
            ans = number1 + number2
           
            myLabel.text = "\(ans)"
            
            print(ans)
        }
        
        if btnTxt == "-"
        {
            ans = number1 - number2
            
            myLabel.text = "\(ans)"
            
            print(ans)
        }
        
        if btnTxt == "*"
        {
            ans = number1 * number2
            
            myLabel.text = "\(ans)"
            
            print(ans)
        }
        
        if btnTxt == "/"
        {
            ans = number1 / number2
            
            myLabel.text = "\(ans)"
            
            print(ans)
        }
        
        if btnTxt == "＾"
        {
            ans = number1 * number1
            
            myLabel.text = "\(ans)"
            
            print(ans)
        }
        
        if btnTxt == "＾"
        {
            ans = number1 * number1
            
            myLabel.text = "\(ans)"
           
            print(ans)
        }
        
        if btnTxt == "%"
        {
            ans = number1 / 100
            
            myLabel.text = "\(ans)"
            
            print(ans)
       
        }
    
    
    }
    
       @IBAction func equalBtn(_ sender: UIButton) {
        
        number2 = getnumber
        
        Cal()
    }
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

       

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
