//
//  PlaylistMainViewController.swift
//  RPD
//
//  Created by Raul Moreno on 13/06/21.
//

import RealmSwift
import UIKit

class PlaylistMainViewController: UIViewController {
    private let realm = try! Realm()
    public var item: PlaylistItem?
    var modelRealm = ModelRealm()
    
    @IBOutlet var itemLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asigna al label vacio el nombre de la playlist
        itemLabel.text = item?.item
        
        modelRealm.getVideosRealm()
    }
    

    @IBAction func didTapAddButton(){
        let currentPlaylistName = item
        guard let searchViewController = storyboard?.instantiateViewController(identifier: "search") as? SearchViewController else {
            return
        }
        searchViewController.item = currentPlaylistName
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    


}
