

import RealmSwift
import UIKit

class CreatePlaylistViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var textField: UITextField!
    
    //  Hacemos referencia a la BD
    private let realm = try! Realm()
    
    /*
        Declaramos un controlador de finalizacion
        Cuando acabe la operacion de guardar una nueva lista, podemos llamar este bloque.
        Asi, el otro controller que muestra la lista de playlists podra saber que se agregò una nueva playlist
        y asi sabra que se tiene que refrescar a si mismo
    */    
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hacemos que el teclado aparezca automaticamente
        textField.becomeFirstResponder()
        textField.delegate = self
        
    }
    
    // Quita el teclado cuando terminas de escribir en el text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didTapSaveButton(){
        //Revisa si hay texto y añade la informacion a la BD
        if let text = textField.text, !text.isEmpty{
            
            realm.beginWrite()
            
            let playlist = PlaylistItem()
            playlist.item = text
            realm.add(playlist)
            
            try! realm.commitWrite()
            
            // Nos regresa a la pantalla principal
            navigationController?.popToRootViewController(animated: true)
            completionHandler?()
            
        }else{
            print("Add text")
            
            let alert = UIAlertController(title: "Notification", message: "Add some text please", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    


}
