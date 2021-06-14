//
//  YoutubeAPI.swift
//  RPD
//
//  Created by Raul Moreno on 14/06/21.
//

import Foundation

struct YoutubeAPI {
    static var KEY = "key=AIzaSyAIpvZTV3Vjh8XpwVhCDrImlcOCYo6hc1E"
    static var BASE_URL_START = "https://www.googleapis.com/youtube/v3/search?\(KEY)&maxResults=10&order=relevance&part=snippet&q="
    static var query = "BP"
    static var type = "&type=video"
    
    
           
}
