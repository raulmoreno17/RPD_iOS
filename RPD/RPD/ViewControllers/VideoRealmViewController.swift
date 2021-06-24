
import UIKit
import WebKit

class VideoRealmViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var titleReceived: String?
    var videoIdReceived: String?
    var channelReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = ""
        channelLabel.text = ""
        
        let embedUrlString = YoutubeAPI.YT_EMBED_URL + videoIdReceived!
        
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Añadir el titulo
        titleLabel.text = titleReceived
        //  Añadir el nombre del canal
        channelLabel.text = channelReceived
        
    }

}
