//
//  OverviewViewController.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 09/11/2021.
//

import UIKit
import Combine
import SwiftUI

class OverviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    private var coffeeSubscribers: AnyCancellable?
    @IBOutlet weak var brewCoffeeButton: UIButton!
    let defaults = UserDefaults.standard
    var selectedTypeId = UserDefaults.standard.object(forKey: "CoffeeTypeId") as! String
    var selectedSizeId = UserDefaults.standard.object(forKey: "SizeId") as! String
    var selectedExtrasIds = UserDefaults.standard.object(forKey: "ExtrasIds") as? [String] ?? [String]()
    
    private var coffeeNames = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoffees()
        setupButtons()
    }
    
    
    private func fetchCoffees() {
        coffeeSubscribers = NetworkManager().coffeePublisher
            .sink(receiveCompletion: { _ in}, receiveValue: { (coffees) in
                self.coffeeNames.append(coffees.types.first { $0.id == self.selectedTypeId }!.name)
                self.coffeeNames.append(coffees.sizes.first { $0.id == self.selectedSizeId }!.name)
                for selectedExtrasId in self.selectedExtrasIds {
                    var foundExtra = coffees.extras.first {$0.id == selectedExtrasId}!
                    if (foundExtra.name == "Select the amount of sugar") {
                        foundExtra.name = "Sugar"
                    }
                    if (foundExtra.name == "Select type of milk") {
                        foundExtra.name = "Milk"
                    }
                    self.coffeeNames.append(foundExtra.name)
                }
            })
    }
    
    func setupButtons(){
        backButton.addTarget(self, action: #selector(presentPreviousView), for: .touchUpInside)
        brewCoffeeButton.addTarget(self, action: #selector(presentFirstView), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeeNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell") as! OverviewTableViewCell
        let coffeeName = self.coffeeNames[indexPath.item]
        
        cell.selectedBackgroundView = UIView()
        cell.overviewImageView.image = UIImage(named:coffeeName)
        cell.OverviewLabel.text = coffeeName
        return cell
    }
    
    @objc func presentView() {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "OverviewViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func presentPreviousView(){
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "ExtrasViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func presentFirstView(){
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "NFCTabViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
