//

import Foundation

class Model {
    
    func getVideos(){
    
        //  Crear un URL object
        let url = URL(string: YoutubeAPI.BASE_URL_START + YoutubeAPI.query + YoutubeAPI.type)
        
        // Url podria ser nil, por lo que ponemos un guard
        guard url != nil else { return }
        
        //  Obtener un URLSession object
        let session = URLSession.shared
        
        //  Obtener un data task del URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //  Revisar si hubo algun error
            if error != nil || data == nil { return }
            
            // Pasando la informacion dentro de objetos de Video
            do {
                let decoder = JSONDecoder()
                //decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                
                // Para probar si funciona el response
                dump(response)
            }
            catch{
                
            }
            
            
            
        }
        
        
        //  Kick off the task
        dataTask.resume()
    }
    
    
}
