import UIKit
import WebKit

class HelpVC: UIViewController {

    var wvHelp: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        wvHelp = WKWebView(frame: .zero, configuration: webConfiguration)
        view = wvHelp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.loadHtml()
    }

    func initViews(){
        self.navigationItem.title = "How to use"
    }
    
    func loadHtml(){
        let htmlPath = Bundle.main.path(forResource: "help", ofType: "html")
        let htmlUrl = URL(fileURLWithPath: htmlPath!, isDirectory: false)
        self.wvHelp.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
    }
    
    
}
