//
//  SearchViewController.swift
//  RPD
//
//  Created by Raul Moreno on 14/06/21.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var model = Model()
    
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hacemos que el teclado aparezca automaticamente
        textField.becomeFirstResponder()
        textField.delegate = self
        
        model.getVideos()
        
        
    }
    
    // Quita el teclado cuando terminas de escribir en el text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
