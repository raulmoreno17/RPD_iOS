//
//  songTableViewCell.swift
//  RPD
//
//  Created by Raul Moreno on 14/03/21.
//

import UIKit

class songTableViewCell: UITableViewCell {
    
    static let identifier = "songTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "songTableViewCell", bundle: nil)
    }
    @IBOutlet var button: UIButton!
    
    @IBAction func didTapButton(){
        
    }
    
    func configure(with title: String){
        button.setTitle(title, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 13.0, *) {
            button.setTitleColor(.label, for: .normal)
        } else {
            // Fallback on earlier versions
        }
    }

   
    
}
