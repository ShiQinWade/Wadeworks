
import UIKit
//建立屬性
struct User {
    var name:String?
    var email:String?
    var number:String?
    var image:String?
}
//Decodable是struct服從Decodable的協定
//由於 JSONDecoder().decode(AllData.self, from: loadData)需帶入協定，故須中遵從協定Decodable
struct AllData:Decodable {
    //當字典內陣列內容屬性建立完成時，就可以標示型別
    var results : [SingleData]?
    //Dictionary字典是Json資料格式符號{}
    //Array陣列是Json資料格式符號[]
//   當Json的資料是Dictionary字典時型別是Any?
//    var results : Any?
}
//Decodable是struct服從Decodable的協定
struct SingleData:Decodable {
    //當字典內陣列內容屬性建立完成時，就可以標示型別
    var name: Name?
    var email:String?
    var phone:String?
    var picture:Picture?
//當屬性是字典，原生碼。
//    var name: Any?
//    var email:String?
//    var phone:String?
//    var picture:Any?
}
struct Name:Decodable {
    var first:String?
    var last:String?
}
struct Picture:Decodable {
    var large:String?
}

class ViewController: UIViewController {

    var downloading = false
    //建立屬性
    var infoTableViewController : InfoTableViewController?
    //建立屬性API網址，型別字串
    let apiAddress = "https://randomuser.me/api/"
    //產生一個URLSession存進urlSession
    var urlSession = URLSession(configuration: .default)
    
    //刷新下載資料
    @IBAction func userChange(_ sender: UIBarButtonItem) {
        //如果不是正在下載，取得新的資料
        if downloading == false{
            downloadInfo(webAddress: apiAddress)
        }
    
    }
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    //建立一個方法，參數是連結API網址的字串
    func downloadInfo(webAddress:String){
    //  轉換成網址，參數名為webAddress，執行downloadInfo的方法時，有將字串轉換成URL，每次執行方法時可帶入不同的字串，因為任何字串都可以執行，如果直接帶入apiAddress，每次方法只會轉換apiAddress為ＵＲＬ
       //參數名是一個字串
        if let url = URL(string: webAddress){
           //下載資料的方法
            let task = urlSession.dataTask(with: url, completionHandler:  {(data , respond ,error)in
               //如果錯誤不等於nil(沒有值)
                if error != nil{
                    //取得網路錯誤操作的code代碼
                    let errorCode = (error! as NSError).code
                    
                    if errorCode == -1009{
                        //當沒有連結網路時，跳出警告控制器。
                        DispatchQueue.main.async
                            { self.popAlert(title: "I can’t connect to the Internet!") }
                    }
                    else{
                        //需使用共時佇列，否則會先讓資料下載完，才能對警告控制器進行操作
                        DispatchQueue.main.async
                            {self.popAlert(title: "something wrong")}
                    }
                    //不是正在下載
                    self.downloading = false
                    //跳出，不再執行錯誤
                    return
                }
                
                if let loadData = data {
                    do{
                        //負責解析Json的物件的decode方法存進okData
                        //AllData目前是一個協定，from下載資料
                    let okData =  try  JSONDecoder().decode(AllData.self, from: loadData)
                        //
                    let firstName =  okData.results?[0].name?.first
                    let lastName = okData.results?[0].name?.last
                        let fullName : String? = {
                           //確保firstName有值，否則回傳nil
                            guard let okFirstName = firstName else{return nil}
                           guard let okLastName = lastName else{ return nil }
                            return okFirstName + "  " + okLastName }()
                        
                    let email = okData.results?[0].email
                    let phone =   okData.results?[0].phone
                    let picture = okData.results?[0].picture?.large
                        
                     let aUser  = User(name: fullName, email: email, number: phone, image: picture)
                        
                        //非同步執行
                DispatchQueue.main.async
                            {self.settingInfo(user: aUser)}
                        }
                    catch{
                        //需使用共時佇列，否則會先讓資料下載完，才能對警告控制器進行操作
                        DispatchQueue.main.async
                            {self.popAlert(title: "something wrong")}
                        self.downloading = false
                    }
                   
                    }
                else{
                    self.downloading = false
                }
            })
            //開始下載
            task.resume()
            downloading = true
                }
            }
    
   
//    func parseJson(json:Any){
//        if let okJson =  json as?[String:Any]{
//            if  let infoArray = okJson["results"] as? [[String:Any]]{
//              let infoDictionary =  infoArray[0]
//            print(infoDictionary["name"])
//
//            }
//
//        }
//    }
    
    
    
    

    //新增方法，接受參數(user:User)
    func settingInfo(user:User){
        //取得參數內容user.name，user.name的user是(user:User)裡的user
        userName.text = user.name
       //取得參數內容，user.name的user是(user:User)裡的user
        infoTableViewController?.phoneLabel.text = user.number
       //取得參數內容，user.name的user是(user:User)裡的user
        infoTableViewController?.emailLabel.text = user.email
        //
        if let imageAddress = user.image{
           //將至字串轉型成URL
            if let imageUrl =  URL(string: imageAddress){
           //下載URL
                let task =  urlSession.downloadTask(with: imageUrl, completionHandler:  {(data , response , error)in
                if error != nil{
                    //需使用共時佇列，否則會先讓資料下載完，才能對警告控制器進行操作
                    DispatchQueue.main.async
                        {self.popAlert(title: "something wrong")}
                    self.downloading = false
                    return
                }
                if let okURL = data {
        do{
            let downloadImage = UIImage(data: try Data(contentsOf: okURL))
            DispatchQueue.main.async
            {self.userImage.image = downloadImage}
           //成功下載，下載停止
            self.downloading = false
            }
                
    catch{
        DispatchQueue.main.async
            {self.popAlert(title: "something wrong")}
        //如果下載失敗，停止下載
        self.downloading = false
                    }
                }
                else{
                    //如果沒有data，停止下載
                    self.downloading = false
                }
            })
            
            task.resume()
            downloading = true
            }
           else{downloading = false}
        }
        else{
            downloading = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //如果identifier是連結到moreinfo的segue時
        if segue.identifier == "moreinfo"{
            //取得segue.destination目的地並轉型，存進infoTableViewController屬性裡
            infoTableViewController = segue.destination as?InfoTableViewController
        }
    }
    
    //增加方法，警告控制器
    func popAlert(title : String) {
        let alert = UIAlertController(title: title, message: "The Internet is down!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(alertAction)
    }
    
    
    
    //當畫面已經顯示在銀幕上時，才會執行的程式碼。
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //調整圖片形狀，不能放在override func viewDidLoad() ，因為剛執行時，介面大小尚未確認，如果放在裡面，只有4邊角會改變，上下左右一樣是直線，變成橢圓形。
        //layer負責繪製，cornerRadius圓角，frame.size.width / 2寬度的一半
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        //把圖片變成圓的
        userImage.clipsToBounds = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //調整Bar顏色
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.67, green: 0.2, blue: 0.157, alpha: 1)
        
        //調整標題顏色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        //        //參數產生實體，存進aUser
        //        let aUser = User(name: "Wade", email: "evans9702@yahoo.com.tw", number: "0926261121", image: "http://image.me")
        //       //呼叫方法，把參數帶入
        //        settingInfo(user: aUser)
        //呼教方法
        downloadInfo(webAddress: apiAddress)
    }
    
}

