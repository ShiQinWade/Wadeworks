//
//  ViewController.swift
//  猜彈專家
//
//  Created by WADE on 2019/4/1.
//  Copyright © 2019 WADE. All rights reserved.
//

import UIKit
import GameKit


class ViewController: UIViewController {
 
     var ans = GKRandomSource.sharedRandom().nextInt(upperBound: 100) + 1
    var maxNumber = 100
    var minNumber = 1
    
    //這邊的False是遊戲正在進行，             當變成True時遊戲結束
    //     False(不是)overGame(結束遊戲)，                   True(是)overGame(結束遊戲)
   //overGame 結束遊戲
    var overGame = false
    
    
    private var counter = 6
    
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLable: UILabel!
    @IBOutlet weak var myText: UITextField!
    
    @IBOutlet weak var gameTimeTxt: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    @IBAction func myBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        let button = sender as!UIButton
        print(self.counter)
        if overGame == false{
            print(ans)
            let inputTxt =  myText.text!
            myText.text = ""
            
            
            var inputNumber = Int(inputTxt)
            if inputNumber == nil{
                myLable.text = "請輸入數字\(minNumber)~\(maxNumber)  "
                
          
            }
            
         
            else{
                if inputNumber! >= maxNumber{
                    myLable.text = "請輸入有效數字\(minNumber)~\(maxNumber)"
                   }
                
                else if inputNumber! <= minNumber{
                    myLable.text = "請輸入有效數字\(minNumber)~\(maxNumber)"
                    
                }
                else if inputNumber! == ans{
                    self.counter-=1
                    myLable.text = "恭喜你成功猜除炸彈"
                    
                     gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
                    button.setTitle("重新開始", for: .normal)
                    myImage.image = UIImage.init(named:"熄火炸彈")
                   overGame = true
                }
                else{
                    self.counter-=1
                    
                    if self.counter == 0 && inputNumber! != ans
                    {
                        myLable.text = "很遺憾猜除炸彈失敗"
                        gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
                        
                        button.setTitle("重新開始", for: .normal)
                        myImage.image = UIImage.init(named: "爆炸")
                        overGame = true}
                    else{
                    if inputNumber! > ans{
                       maxNumber = inputNumber!
                        myLable.text = "請繼續猜彈\(minNumber)~\(maxNumber)"
                       gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
                    }
                    else if inputNumber! < ans{
                        minNumber = inputNumber!
                        myLable.text = "請繼續猜彈\(minNumber)~\(maxNumber)"
                        gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
                    }
                    else if inputNumber! == ans{
                        myLable.text = "恭喜你成功猜除炸彈"
                         gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
                        button.setTitle("重新開始", for: .normal)
                        overGame = true
                        myImage.image = UIImage.init(named:"熄火炸彈")
                    }
                    }

          
                    
                    
                }
                
            }
            
        }
        else
            {
                
            maxNumber = 100
            minNumber = 1
            counter = 6
            ans = GKRandomSource.sharedRandom().nextInt(upperBound: 100) + 1
             myLable.text = "請輸入數字\(minNumber)~\(maxNumber)  "
            button.setTitle("猜彈", for: .normal)
                overGame = false
            gameTimeTxt.text = "剩餘猜彈次數：\(self.counter)"
              myImage.image = UIImage.init(named: "炸彈")
        }
        

        
        }//32行Button的{}
    
    
    
    
    
 
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
            myText.becomeFirstResponder()
            
          
                myText.keyboardType = .numberPad
            
    }


}


