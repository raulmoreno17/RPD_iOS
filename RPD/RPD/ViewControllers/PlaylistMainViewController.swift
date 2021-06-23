//
//  PlaylistMainViewController.swift
//  RPD
//
//  Created by Raul Moreno on 13/06/21.
//

import RealmSwift
import UIKit

class PlaylistMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let realm = try! Realm()
    public var item: PlaylistItem?
  
    var Songs = [String]()
    var Thumbnails = [String]()
    var Channels = [String]()
    var VideoIds = [String]()
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Se asigna a si mismo como el dataSource y delegate
        tableView.dataSource = self
        
        // Asigna al label vacio el nombre de la playlist
        itemLabel.text = item?.item
        
        querySongs()
        
    }
    

    @IBAction func didTapAddButton(){
        let currentPlaylistName = item
        guard let searchViewController = storyboard?.instantiateViewController(identifier: "search") as? SearchViewController else {
            return
        }
        searchViewController.item = currentPlaylistName
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    // Se activa cuando te mueves al videoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Confirmar que un video fue presionado
        guard tableView.indexPathForSelectedRow != nil else { return }
        
        
        //  Obtener una referencia a el videoViewController
        let videoRealmViewController = segue.destination as! VideoRealmViewController
        videoRealmViewController.titleReceived = Songs[tableView.indexPathForSelectedRow!.row]
        videoRealmViewController.channelReceived = Channels[tableView.indexPathForSelectedRow!.row]
        videoRealmViewController.videoIdReceived = VideoIds[tableView.indexPathForSelectedRow!.row]
        
        
    }
    
    //  Metodos para el tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : VideoRealmTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideoRealmCell", for: indexPath) as! VideoRealmTableViewCell
        
        cell.titleLabel.text = Songs[indexPath.row]
        
        //  Descarga la informacion de thumbnail
        let url = URL (string: Thumbnails[indexPath.row])
        // Obtiene el sharedURL session object
        let session = URLSession.shared
        
        //  Crea un data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                //  Revisa que el url descargado coincida con el url de la thumbnail del video que actualmente se muestra
                if url!.absoluteString != self.Thumbnails[indexPath.row]{
                    //  La celda ha sido reciclada por otro video y no coincide con la miniatura que fue descargada
                    return
                }
                // Create el objeto de la imagen
                let image = UIImage(data: data!)
                // Añade la imageView
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = image
                }
            }
        }
        dataTask.resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func querySongs(){
        let realm = try! Realm()
        let allSongs = realm.objects(SongItem.self)
        for song in allSongs{
            if (song.playlist == item!.item){
            
            Songs.append(song.title)
            Channels.append(song.channel)
            Thumbnails.append(song.thumbnail)
            VideoIds.append(song.videoId)
            }
        }
        tableView.reloadData()
        
    }
    
    


}
