import Foundation
class RSSParserDelegate: NSObject,XMLParserDelegate {
   
    //一開始currentItem currentElementValue 的值是nil，任何?初始直為nil
    
    //儲存解析的新聞
    var currentItem : NewsItem?
    //儲存解析的文字
    var currentElementValue : String?
   //儲存NewsItem得陣列(結果)
    var resultArray = [NewsItem]()
    //當碰到某個開始標籤方法，就會觸發方法
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       
    //  當觸碰到網站裡的標籤時
        if elementName == "item"{
            //產生 NewsItem()的實體，準備存讀到的資料，存進currentItem
            currentItem = NewsItem()
        }else if elementName == "title"{
            //currentElementValue為nil，是因為準備解析title標籤裡面的文字
            currentElementValue = nil
        }
        else if elementName == "link"{
            currentElementValue = nil
        }
    }
    //當碰到某個結束標籤，就會觸發方法
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            if currentItem != nil{
                //如果currentItem如果有值的話（title跟link），就將currentItem!加到resultArray裡面，所有解析到新聞的值存進resultArray裡。
                resultArray.append(currentItem!)
           // 再把currentItem設定成nil，完成解析新聞
                currentItem = nil
                
            }
        }else if elementName == "title"{
         //  當解析到標籤title時，就會將所有解析到的值，存進currentItem?.title裡
            currentItem?.title = currentElementValue
        }
        else if elementName == "link"{
          //  當解析到標籤title時，就會將所有解析到的值，存進currentItem?.link裡
            currentItem?.link = currentElementValue
        }
        //就會把currentElementValue清空，準備解析其他資料link，先解析title結束後，在解析link
        currentElementValue = nil
    }
    //當解析到什麼資料，就會觸發方法
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if currentElementValue == nil{
            //把讀到的第一個字母存到currentElementValue，此時currentElementValue已經有值了
            currentElementValue = string
        }
        else {
            //讀到第二個字母時，也會觸發第一個方法，因為第一個方法已經有值了，就會將第二個字母加上後面，持續直到所有字母都讀完以後，會碰到網站裡的標籤（title或是link），就會執行結束標籤的方法
            currentElementValue   = currentElementValue! + string
        }
    }
    //回傳一個陣列，包含NewsItem物件的陣列
    func getResult() -> [NewsItem] {
       //回傳resultArray所有解析到的陣列
        return resultArray
    }
}
