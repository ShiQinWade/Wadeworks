import UIKit
import WebKit
class WebViewController: UIViewController ,WKNavigationDelegate{

    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    var linkFromViewOne : String?
    
    
    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //如果linkFromViewOne有值存進okLink，就將okLink值String轉型成URL
        if let okLink = linkFromViewOne,let okURL = URL(string: okLink){
           let request =  URLRequest(url: okURL)
            //載入網頁
            myWebView.load(request)
            
        }
        myWebView.navigationDelegate = self
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        myActivity.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivity.stopAnimating()
    }

}
