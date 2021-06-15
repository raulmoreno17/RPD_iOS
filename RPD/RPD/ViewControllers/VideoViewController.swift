

import UIKit
import WebKit

class VideoViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var channelLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var saveVideoButton: UIButton!
    
    var video:Video?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //  Limpia los campos
        titleLabel.text = ""
        channelLabel.text = ""
        
        //  Revisa si hay un video
        guard video != nil else { return }
        
        //  Crear la url embebida
        let embedUrlString = YoutubeAPI.YT_EMBED_URL + video!.videoId
        
        //  Cargarla dentro del webView
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        // Añadir el titulo
        titleLabel.text = video!.title
        
        //  Añadir el nombre del canal
        channelLabel.text = video!.channelTitle
        
    
    }


}
