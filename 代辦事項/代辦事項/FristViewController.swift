

import UIKit

class FristViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
   
    
    //隱藏狀態列
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var mySearch: UISearchBar!
    //字型
    var willDothing = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return willDothing.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //Table裡的內容
        cell.textLabel?.text = willDothing[indexPath.row]
        //Table裡文字的顏色
        cell.textLabel?.textColor = UIColor.red
        //Table裡文字的字型與大小
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
    return cell
    }
    //刪除的方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete{
           //刪除indexPath.row的項目
            willDothing.remove(at: indexPath.row)
           //刪除過後，再重新儲存新的陣列，否則下次執行項目就還在
            UserDefaults.standard.setValue(willDothing, forKey: "willdothing")
            //刷新資料
            myTableView.reloadData()
        }
    }
    //當按到選項裡的accessoryButton按鈕時，就可以更改內容
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
       //找出tabBarController裡的viewControllers?[1]畫面的第一號成員(第二個畫面)as?AddListViewController如果真的成功轉型成AddListViewController，就把它存進addViewController裡
        if let addViewController = tabBarController?.viewControllers?[1] as?AddListViewController{
            //將當前點擊的indexPath.row(想要修改的項目)，存儲到addViewController的infoFromViewOne
            addViewController.infoFromViewOne = indexPath.row
        }
        //回到增加代辦事項的畫面
        tabBarController?.selectedIndex = 1
    }
    
    
//    點選項目時不會反白
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//取出資料裡的內容，將取出的資料存進loadingWilldo
        if let loadingWilldo =  UserDefaults.standard.stringArray(forKey: "willdothing"){
           willDothing = loadingWilldo
        }
        myTableView.delegate = self
        myTableView.dataSource = self
    }

}
