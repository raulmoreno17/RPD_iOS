
import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // variable que contiene el video mostrado
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(_ v:Video){
        self.video = v
        
        //  Aseguramos que tenemos un video
        guard  self.video != nil else { return }
        
        // Añade el titulo
        self.titleLabel.text = video?.title
        
        // Añade la thumbnail
        guard self.video!.thumbnail != "" else { return }
        
        //  Descarga la informacion de thumbnail
        let url = URL (string: self.video!.thumbnail)
        
        // Obtiene el sharedURL session object
        let session = URLSession.shared
        
        //  Crea un data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                //  Revisa que el url descargado coincida con el url de la thumbnail del video que actualmente se muestra
                if url!.absoluteString != self.video?.thumbnail{
                    //  La celda ha sido reciclada por otro video y no coincide con la miniatura que fue descargada
                    return
                }
                
                // Create el objeto de la imagen
                let image = UIImage(data: data!)
            
                // Añade la imageView
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
                
            }
        }
        // Iniciar dataTask
        dataTask.resume()
        
        
    }

}
