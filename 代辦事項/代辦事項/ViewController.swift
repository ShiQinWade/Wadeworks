import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //UserDefaults儲存小型的資料
// UserDefaults.standard.set("Wade", forKey: "Name")
//取出資料
        //as? String不知道可不可以轉型成功為String型別，如果轉型成功就執行{}裡的程式碼。
        
        if let loadName = UserDefaults.standard.value(forKey: "Name") as? String{
            
        }
    }


}

