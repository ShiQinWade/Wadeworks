
import UIKit


struct NewsItem {
   
    //標題
    var title:String?
    //連結，網址
    var link:String?
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //解析的陣列
    var object = [NewsItem]()
   //解析的網址String
    let rssXml = "https://www.cnet.com/rss/news/"
    var session = URLSession(configuration:      .default)
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = object[indexPath.row].title
        return cell
    }
    //消除按到狀態列反白的顏色
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
//        let new1 = NewsItem(title: "firstNew", link: "https://www.apple.com")
//        let new2 = NewsItem(title: "secondNew", link: "https://www.nike.com")
//        let new3 = NewsItem(title: "thirdNew", link: "https://www.udemy.com")
//        object = [new1 , new2 ,new3]
        downloadXml(xmlAddress: rssXml)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //傳遞資料
        if segue.identifier == "showinfo"{
            if  let dvc =  segue.destination as? WebViewController{
                
                if let selectedRow = myTableView.indexPathForSelectedRow?.row{
                    dvc.linkFromViewOne = object[selectedRow].link
                }
            }
        }
    }
    
    
    //增加方法，警告控制器
    func popAlert(title : String) {
        let alert = UIAlertController(title: title, message: "The Internet is down!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(alertAction)
    }

    func downloadXml(xmlAddress : String){
        if let xmlUrl = URL(string:xmlAddress){
            let task =   session.dataTask(with: xmlUrl, completionHandler: {(data,response,error)in
                if error != nil{
                    DispatchQueue.main.async {
                        self.popAlert(title: "Something wrong")
                    }
                    
                    return
                }
               if let okData = data {
                 let parser =  XMLParser(data: okData)
               let rssParserDelegate = RSSParserDelegate()
                parser.delegate = rssParserDelegate
              //如果有成功解析
                if  parser.parse() == true{
                   //取得下載的結果存進obiect
                    self.object = rssParserDelegate.getResult()
                    //更新myTableView的資料
                    DispatchQueue.main.sync {
                        self.myTableView.reloadData() }
                }
                else{return}
                }
            })
            task.resume()
        }
        
    }
}

