//
//  Clase que representa cada uno de los videos que obtendremos de la API

import Foundation

//  Vamos a usar el "Codable protocol", que basicamente convertira los items JSON de la respuesta del API en objetos de tipo Video
struct Video : Decodable {
    
    // Representa cada video que vamos a obtener
    var videoId = ""
    var title = ""
    var channelTitle = ""
    var thumbnail = ""
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case thumbnails
        case high
        case id
        
        case videoId
        case title
        case channelTitle
        case thumbnail = "url"
    }
    
    //  Aqui es donde pasamos los JSON que vamos a decodificar
    init (from decoder: Decoder) throws {
        
        //  Primero obtenemos el JSON principal del item
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //  A partir del JSON principal obtenemos el snippet
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        //  Obtenemos el title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        //  Obtenemos el channelTitle
        self.channelTitle = try snippetContainer.decode(String.self, forKey: .channelTitle)
        
        //  Obtenemos las thumbnails en sus distintas resoluciones
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        //  Obtenemos la thumbnail con calidad alta
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        //  A partir del JSON principal obtenemos el id
        let idContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .id)
        //  Obtenemos el videoId
        self.videoId = try idContainer.decode(String.self, forKey: .videoId)
    }
    
}
