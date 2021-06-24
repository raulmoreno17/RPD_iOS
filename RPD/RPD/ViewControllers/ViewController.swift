
import RealmSwift
import UIKit


//  Definimos el atributo que vamos a usar para guardar cada cancion
class SongItem: Object{
    @objc dynamic var videoId: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var channel: String = ""
    @objc dynamic var thumbnail: String = ""
    @objc dynamic var playlist: String = ""
}

//  Definimos el atributo que vamos a usar para guardar cada nombre de playlist
class PlaylistItem: Object{
    @objc dynamic var item: String = ""
    override static func primaryKey() -> String? {
        return "item"
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let realm = try! Realm()
    @IBOutlet var table: UITableView!
    private var dataPlaylist = [PlaylistItem]() //devuelve un arreglo con objetos, cada objeto es un playlist item
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        dataPlaylist = realm.objects(PlaylistItem.self).map({$0})

        // Se registra el identifier de cell, por que si intentas devolver una celda sin registrar su identificador, la app crashea
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
       
    }
    
    //  Cuenta cuantas filas van a haber en el tableView dependiendo de los datos contenidos en "data"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlaylist.count
    }
    
    //  Crea y retorna una cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        // Se define el texto de la celda dependiendo de la posicion en el data
        cell.textLabel?.text = dataPlaylist[indexPath.row].item
        return cell
    }
    
    // Al presionar una celda, se espera el comportamiento siguiente...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Abre la pantalla principal de la playlist
        let item = dataPlaylist[indexPath.row]
        guard let playlistMainViewController = storyboard?.instantiateViewController(identifier: "playlistMain") as? PlaylistMainViewController else {
            return
        }
        playlistMainViewController.item = item
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
        dataPlaylist = realm.objects(PlaylistItem.self).map({$0})
        table.reloadData()
    }

}




