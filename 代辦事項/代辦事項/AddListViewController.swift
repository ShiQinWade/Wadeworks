
import UIKit

class AddListViewController: UIViewController,UITextFieldDelegate  {
    
    //建立屬性，使用者準備修改的項目列數
    var infoFromViewOne : Int?
    
    @IBOutlet weak var myText: UITextField!
    
    @IBAction func myTextChange(_ sender: UITextField) {
        //sender.text當使用者輸入內容，就可以輸入的取得文字
       //當Text裡沒有輸入內容時(空字串)，按鍵內容為返回
        if  sender.text != ""{
            myButton.setTitle("加入", for: .normal)
        }else
        {
            myButton.setTitle("返回", for: .normal)
        }
    }
    @IBOutlet weak var myButton: UIButton!
    @IBAction func myButtonInput(_ sender: UIButton) {
        
        
    
        if let text = myText.text{
            //如果不是輸入空字串時，將文字內容傳送到FristViewController
            //確保tabBarController?.viewControllers?[0]存在且有值時，就轉型成FristViewController
            guard let  fristViewController = tabBarController?.viewControllers?[0] as?FristViewController else{return}
            //else{return}否則就不在繼續實做
            if text != ""{
              
                //如果取得所有tabBarController?.viewControllers?[0]真的存在且有值時，就轉型成FristViewController
//                if let  fristViewController = tabBarController?.viewControllers?[0] as?FristViewController{  }
                
                //如果infoFromViewOne有值時，就修改內容
                if infoFromViewOne != nil{
                    //將fristViewController的willDothing陣列成員解封包infoFromViewOne存進text裡
                    fristViewController.willDothing[infoFromViewOne!] = text
                   //infoFromViewOne需為nil，否則會以為還是要修改，而不是新增
                    infoFromViewOne = nil
                }
                    //如果不是要修改內容，新增內容的話
                else{
                    // 如果轉型成功時，將文字text裡的內容加入willDothing裡
                    fristViewController.willDothing.append(text)
                }
                   //刷新資料，資料並不會自動加入，需刷新。
                    fristViewController.myTableView.reloadData()
                    //儲存資料，儲存第一個話面當前的事項
                    UserDefaults.standard.setValue(fristViewController.willDothing, forKey: "willdothing")
            }
            else{
                if infoFromViewOne != nil{
                    fristViewController.willDothing.remove(at: infoFromViewOne!)
                    //刷新資料，資料並不會自動加入，需刷新。
                    fristViewController.myTableView.reloadData()
                    //儲存資料，儲存第一個話面當前的事項
                    UserDefaults.standard.setValue(fristViewController.willDothing, forKey: "willdothing")
                    infoFromViewOne = nil
                }
            }
            
        }
        //順序不可以在上面，否則文字內容無法傳送至第一畫面
        myText.text = ""
        myButton.setTitle("返回", for: .normal)
        self.tabBarController?.selectedIndex = 0

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myText.delegate = self
    }
    //鍵盤裡的return跟button一樣，執行內容一樣
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myButtonInput(UIButton())
//       隱藏鍵盤不在是焦點
//        myText.resignFirstResponder()
        return true
    }
//點擊背景後收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        myText.becomeFirstResponder()
        //如果infoFromViewOne不等於沒有值時，就是當infoFromViewOne有儲存值時，就將找到tabBarController?.viewControllers?裡的第一個成員，轉型成FristViewController，存進fristView裡，再將點擊修改的內容willDothing陣列成員infoFromViewOne裡的文字內容存進myText.text
        if infoFromViewOne != nil{
            if let fristViewController = tabBarController?.viewControllers?[0] as?FristViewController{
                //FristViewController裡的infoFromViewOne(修改的陣列成員)放進willDothing陣列
                //[infoFromViewOne!]    !是因為infoFromViewOne已經確定是有值的狀況了，所以直接解封包裝
                myText.text = fristViewController.willDothing[infoFromViewOne!]
                myButton.setTitle("修改", for: .normal)
            }
        }
    }
    
}
