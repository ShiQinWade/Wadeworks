//
//  ViewController.swift
//  AudioView
//
//  Created by WADE on 2019/4/23.
//  Copyright © 2019 WADE. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
 
    
    var audioPlayer : AVAudioPlayer?
    
    @IBAction func paly(_ sender: UIButton) {
        
        
        //停止之前的播放
        
        audioPlayer?.stop()
       // 設定時間點播放
        
        audioPlayer?.currentTime = 0.0
        //播放
        audioPlayer?.play()
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //先定義聲音的路徑ＵＲＬ，產生路徑Url
//這邊做法是當路徑名稱或是路經錯誤不確定時，可以錯誤處理
        //        if let path =   Bundle.main.path(forResource: "測試用聲音", ofType: "m4a"){
//          let url = URL(fileURLWithPath: path)
//            do{
//           audioPlayer = try AVAudioPlayer.init(contentsOf: url)
//               //可以調整數度，true打開
//                audioPlayer?.enableRate = true
//                //調整數度
//                audioPlayer?.rate = 2.0
//                //重複播放次數，0是一次，1是兩次，-1是無限次數
//                audioPlayer?.numberOfLoops = 0
//                //調整音量大小
//                audioPlayer?.volume = 0.5
//
//
//            }catch{
//                error.localizedDescription
//            }
//        }
//        else{
//            print("No audio")
//        }
//
        
        
        
        
        
        
        
        //確定有值，路徑正確的做法 guard
        //確保有檔案的路徑，不然就執行else裡的程式碼，然後跳出
        guard let path = Bundle.main.path(forResource: "測試用聲音", ofType: "m4a") else {
            print("NO audio")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        
        do{
            audioPlayer = try AVAudioPlayer.init(contentsOf: url)
        }
        catch{
           print(error.localizedDescription)
        }
        
        
       
    
    
    
    
    
    }


}

