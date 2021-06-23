//
//  VideoRealmViewController.swift
//  RPD
//
//  Created by Raul Moreno on 23/06/21.
//

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

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
