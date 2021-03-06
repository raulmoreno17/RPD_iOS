

import UIKit
import WebKit
import RealmSwift

class VideoViewController: UIViewController {
    
    // Nombre de la playlist actual
    public var item: PlaylistItem?
    
    let realm = try! Realm()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var saveVideoButton: UIButton!
    
    var video:Video?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("playlist actual: " + item!.item)    }
    
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
    
    @IBAction func didTapSaveButton(){

        let currentSong = SongItem()
        
        currentSong.title = video!.title
        currentSong.channel = video!.channelTitle
        currentSong.videoId = video!.videoId
        currentSong.thumbnail = video!.thumbnail
        currentSong.playlist = item!.item
        
        try! realm.write{
            //playlistItem.songItems.append(currentSong)
            realm.add(currentSong)
        }
        
        let alert = UIAlertController(title: "Notification", message: "Song added successfully!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Got it", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        
    }


}
