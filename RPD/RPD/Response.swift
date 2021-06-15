//


import Foundation


// Asi como decodificamos nuestros items de video, ahora decodificaremos el JSON que contiene esos items
struct Response: Decodable {
    
    var items: [Video]?
    
    enum CodingKeys:String, CodingKey{
        case items
    }
    
    init (from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Video].self, forKey: .items)
    }
    
}
