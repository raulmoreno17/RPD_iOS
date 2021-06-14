//
//  PlaylistMainViewController.swift
//  RPD
//
//  Created by Raul Moreno on 13/06/21.
//

import RealmSwift
import UIKit

class PlaylistMainViewController: UIViewController {

    public var item: PlaylistListItem?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    
    private let realm = try! Realm()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asigna al label vacio el nombre de la playlist
        itemLabel.text = item?.item
    }
    
    // Elimina la playlist actual
    @IBAction func didTapDeleteButton(){
        guard let currentItem = self.item else {
            return
        }
        realm.beginWrite()
        realm.delete(currentItem)
        try! realm.commitWrite()
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func didTapAddButton(){
        guard let searchViewController = storyboard?.instantiateViewController(identifier: "search") as? SearchViewController else {
            return
        }
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    


}
