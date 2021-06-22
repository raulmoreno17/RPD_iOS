//
//  ModelRealm.swift
//  RPD
//
//  Vamos a hacer un Model que va a hacer la llamada a la BD, obtener los datos y enviarlos por el PlaylistMainviewController
//

import Foundation
import RealmSwift

class ModelRealm {
    
    private var dataSongItems = [SongItem]()
    private let realm = try! Realm()
    
    func getVideosRealm() {
        let responseRealm = realm.objects(SongItem.self).map({$0}) // devuelve un arreglo con objetos, cada objeto es un song item
        dump(responseRealm)
        
    }
       
}
