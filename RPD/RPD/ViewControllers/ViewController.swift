//
//  ViewController.swift
//  RPD
//
//  Created by Raul Moreno on 13/03/21.
//

import RealmSwift
import UIKit

//  Definimos el atributo que vamos a usar para guardar cada nombre de playlist
class PlaylistListItem: Object{
    @objc dynamic var item: String = ""
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    private let realm = try! Realm()
    private var data = [PlaylistListItem]()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = realm.objects(PlaylistListItem.self).map({$0})
        
        // Se registra el identifier de cell, por que si intentas devolver una celda sin registrar su identificador, la app crashea
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
       
    }
    
    //  Cuenta cuantas filas van a haber en el tableView dependiendo de los datos contenidos en "data"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //  Crea y retorna una cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        // Se define el texto de la celda dependiendo de la posicion en el data
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    // Al presionar una celda, se espera el comportamiento siguiente...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Abre la pantalla principal de la playlist
        let item = data[indexPath.row]
        guard let playlistMainViewController = storyboard?.instantiateViewController(identifier: "playlistMain") as? PlaylistMainViewController else {
            return
        }
        playlistMainViewController.item = item
        playlistMainViewController.deletionHandler = { [weak self] in self?.refresh()}
        navigationController?.pushViewController(playlistMainViewController, animated: true)
    }
    
    @IBAction func didTapAddButton(){
        guard let createPlaylistViewController = storyboard?.instantiateViewController(identifier: "createPlaylist") as? CreatePlaylistViewController else {
            return
        }
        createPlaylistViewController.completionHandler = { [weak self] in self?.refresh() }
        navigationController?.pushViewController(createPlaylistViewController, animated: true)
    }
    
    @IBAction func didTapInfoButton(){
        guard let infoPlaylistViewController = storyboard?.instantiateViewController(identifier: "info") as? InfoViewController else {
            return
        }
        navigationController?.pushViewController(infoPlaylistViewController, animated: true)
    }
    
    // Recarga todos los items del tableView
    func refresh(){
        data = realm.objects(PlaylistListItem.self).map({$0})
        table.reloadData()
    }

}




