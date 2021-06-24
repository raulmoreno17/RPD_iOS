
import Foundation

struct YoutubeAPI {
    static var KEY = "key=AIzaSyAIpvZTV3Vjh8XpwVhCDrImlcOCYo6hc1E"
    static var BASE_URL_START = "https://www.googleapis.com/youtube/v3/search?\(KEY)&maxResults=10&order=relevance&part=snippet&q="
    static var query = "BP"
    static var type = "&type=video"
    
    static var VIDEOCELL_ID = "VideoCell"
    static var YT_EMBED_URL = "http://www.youtube.com/embed/"
    
           
}
