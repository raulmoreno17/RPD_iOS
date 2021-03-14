//
//  ViewController.swift
//  RPD
//
//  Created by Raul Moreno on 13/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    struct Song {
        var name: String
        var artist: String
    }
    
    let songs = [
        Song( name: "Song sample", artist: "Singer sample 1" ),
        Song( name: "Song sample", artist: "Singer sample 2" ),
        Song( name: "Song sample", artist: "Singer sample 3" ),
        Song( name: "Song sample", artist: "Singer sample 4" ),
        Song( name: "Song sample", artist: "Singer sample 5" ),
    ]
    
    let data = ["first","second"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(songTableViewCell.nib(), forCellReuseIdentifier: songTableViewCell.identifier)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("me presionaste!")
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        
        //let cell = tableView.dequeueReusableCell(withIdentifier: songTableViewCell.identifier, for: indexPath) as! songTableViewCell
        //cell.configure(with: data[indexPath.row])
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        cell.imageView?.image = UIImage(named: song.name + " img" )
        
        return cell
    }
}

