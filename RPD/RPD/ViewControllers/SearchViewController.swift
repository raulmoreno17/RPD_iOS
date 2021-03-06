//
//  SearchViewController.swift
//  RPD
//
//  Created by Raul Moreno on 14/06/21.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, ModelDelegate {
    
    //  Nombre de la playlist actual
    public var item: PlaylistItem?
    
    // El table view solo muestra informacion, pero no contiene informacion en si mismo. Para esto tiene que llamar a un dataSource que por default esta vacio. El dataSource debe tener ciertos metodos especificos (Protocols) para proveer la informacion y que el table view lo entienda. Para esto nos aseguraremos de que nuestro viewController tiene estos protocolos
    
    //  No es posible escribir codigo en el tableView para tratar la interaccion del usuario. Existe una propiedad que funciona de forma parecida al dataSource, se llama delegate. Por defecto esta vacio y si no le mandamos nada, el tableView no harà nada cuando demos tap en la lista. Igualmente tenemos que darle un delegate con ciertos protocolos especificos
    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    
    // Arreglo vacio de videos para testear
    var videos = [Video]()
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hacemos que el teclado aparezca automaticamente
        textField.becomeFirstResponder()
        textField.delegate = self
        
        // Aqui asignamos al viewController como dataSource y delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Se asigna a si mismo como delegate del model
        model.delegate = self
        
    }
    
    @IBAction func didTapSearchButton(){
        //Revisa si hay texto e inicia la busqueda
        if let text = textField.text, !text.isEmpty{
            
            let query = text.lowerKebabCased()
            model.getVideos(query: query)
            
        }else{
            print("Add text")
        }
        
    }
    
    // Se activa cuando te mueves al videoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Confirmar que un video fue presionado
        guard tableView.indexPathForSelectedRow != nil else { return }
        
        // Obtener una referencia a el video que se presionò
        let selectedVideo = videos[tableView.indexPathForSelectedRow!.row]
        
        //  Obtener una referencia a el videoViewController
        let videoViewController = segue.destination as! VideoViewController
        videoViewController.video = selectedVideo
        videoViewController.item = item
    }
    
    
    // Quita el teclado cuando terminas de escribir en el text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //  Metodos para el ModelDelegate
    
    func videosFetch(_ videos: [Video]) {
        // Añade los videos retornados a nuestro video property
        self.videos = videos
        
        //  Refresca el tableView
        tableView.reloadData()
    }
    
    
    //  Metodos para el TableView
    
    //      Devuelve el numero de rows detectados
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    //      Inserta una celda en el tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  Indica que template vamos a usar para el cell, especificamente es el que hicimos en VideoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: YoutubeAPI.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        // Configura la celda con la informacion
        let video = self.videos[indexPath.row]
        cell.setCell(video)
        
        // Retorna la cell
        return cell
    }
    
    //Gestiona las acciones a realizar cuando presionas una row del tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
   }
    
    
    
    

}

/// An extension to format strings in *kebab case*.
extension String {
    /// A collection of all the words in the string by separating out any punctuation and spaces.
    var words: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }

    /// Returns a lowercased copy of the string with punctuation removed and spaces replaced
    func lowerKebabCased() -> String {
        return self.words.map({ $0.lowercased() }).joined(separator: "-")
    }
}
