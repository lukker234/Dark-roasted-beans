//
//  NFCTabViewController.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 06/11/2021.
//

import UIKit

class NFCTabViewController: UIViewController {
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var NFCTabButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }
    
    func setupButtons(){
        NFCTabButton.addTarget(self, action: #selector(presentView), for: .touchUpInside)
        helpButton.addTarget(self, action: #selector(setupAlert), for: .touchUpInside)
    }
    
    @objc func presentView() {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "StyleViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func presentHelpView() {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "StyleViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func setupAlert(){
        let alert = UIAlertController(title: "", message: "Eventually you can tap the coffee machine to create your coffee, unfortunately this functionality doesn't work yet. You can start creating your own coffee by clicking on the image", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }

}
