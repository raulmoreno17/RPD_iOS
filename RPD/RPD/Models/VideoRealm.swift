//
//  VideoRealm.swift
//  RPD
//
//  Primero vamos a crear una clase para representar cada uno de los videos que obtendremos de la base de datos de Realm
//

import Foundation

struct VideoRealm : Decodable {
    
    // Representa cada video que vamos a obtener
    var videoId = ""
    var title = ""
    var channel = ""
    var thumbnail = ""
    
    // Especificamos los atributos del objeto del que extraeremos la informacion, en seguida se ocupa en el forKey: .<key>
    enum CodingKeys: CodingKey{
        case videoId
        case title
        case channel
        case thumbnail
    }

    // Vamos a pasar cada objeto songItem del arreglo a este metodo inicializador
    init (from decoder: Decoder) throws {
        // Contenedor de la informacion, tambien conocido como el objeto songItem
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Obtenemos la informacion de cada atributo
        self.videoId = try container.decode(String.self, forKey: .videoId)
        self.title = try container.decode(String.self, forKey: .title)
        self.channel = try container.decode(String.self, forKey: .channel)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
    }
    
    
}
