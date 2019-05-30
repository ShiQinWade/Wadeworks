//
//  ViewController.swift
//  算命師
//
//  Created by WADE on 2019/4/22.
//  Copyright © 2019 WADE. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox



class ViewController: UIViewController {
//隱藏上方狀態列
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBAction func theButton(_ sender: UIButton) {
        
        
        showAns()
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       //手機發生什麼事件，系統就會叫motionEnded方法
        //如果事件是搖晃手機時，就會執行showAns
        //測試Hardware>shake Gestrue
        if event?.subtype == .motionShake   {
            showAns()
        }
    }
    
    func showAns(){
       //0~5的亂數+1才等於1~5的亂數
        
        if myImage.isHidden == true{
            let game = GKRandomSource.sharedRandom().nextInt(upperBound: 5)+1
            
            
            myImage.image =    UIImage.init(named: "\(game)")
            myImage.isHidden = false
            AudioServicesPlayAlertSound(1110)
        }
        else{
            myImage.isHidden = true
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

