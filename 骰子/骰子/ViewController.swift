//
//  ViewController.swift
//  骰子
//
//  Created by Cheetah on 2019/1/29.
//  Copyright © 2019年 Cheetah. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    


    @IBOutlet weak var myTxt3: UITextField!
    @IBOutlet weak var myTxt2: UITextField!
    @IBOutlet weak var myTxt1: UITextField!
    @IBOutlet var rightDices: [UIImageView]!
    @IBOutlet var leftDices: [UIImageView]!
    

    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    

    
    
    let images = ["骰子1","骰子2","骰子3","骰子4","骰子5","骰子6"]
    var random : GKRandomDistribution!
    var leftSum = 0
    var rightSum = 0
    var sum = 0
    @IBAction func dicesButtonPress(_ sender: UIButton) {
        switch sender {
        case leftButton:
            leftSum = 0
            for i in 0...2{
                let number = random.nextInt()
                let imageName = images[number-1]
                leftDices[i].image = UIImage(named:imageName )
                leftSum += number
            }
            myTxt1.text = "\(leftSum)"
        case rightButton:
            rightSum = 0
            for i in 0...2{
                let number = random.nextInt()
                let imageName = images[number-1]
                rightDices[i].image = UIImage(named: imageName)
                rightSum += number
                
            }
            myTxt2.text = "\(rightSum)"
        
  
            
            
            
        default:
            break
        }
        sum = leftSum + rightSum
        myTxt3.text = "\(sum)"


            }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        random = GKRandomDistribution(lowestValue: 1, highestValue: images.count)
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

