//
//  ExtrasViewController.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 07/11/2021.
//

import UIKit
import Combine

class ExtrasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overviewButton: UIButton!
    
    private var coffeeSubscribers: AnyCancellable?
    let defaults = UserDefaults.standard
    var selectedSizeId = UserDefaults.standard.object(forKey: "SizeId") as! String
    var selectedCoffeeTypeId = UserDefaults.standard.object(forKey: "CoffeeTypeId") as! String
    var selectedExtrasIds = [String]()
    var isOpened = [Int: Bool]()

    private var coffeesExtra = [Coffee.Extra]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoffeesExtras()
        setupButtons()
    }
    
    private func fetchCoffeesExtras() {
        coffeeSubscribers = NetworkManager().coffeePublisher
            .sink(receiveCompletion: { _ in}, receiveValue: { (coffees) in
                for coffeeType in coffees.types {
                    if (coffeeType.id == self.selectedCoffeeTypeId) {
                        for coffeeExtra in coffeeType.extras {
                            for coffeesExtra in coffees.extras {
                                if coffeesExtra.id == coffeeExtra {
                                    self.coffeesExtra.append(coffeesExtra)
                                }
                            }
                        }
                    }
                }
            })
    }
    
    func setupButtons(){
        backButton.addTarget(self, action: #selector(presentPreviousView), for: .touchUpInside)
        overviewButton.addTarget(self, action: #selector(presentView), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeesExtra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.allowsMultipleSelection = true
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExtraCell") as! CoffeeTableViewCell
        var coffeesExtra = self.coffeesExtra[indexPath.item]
        
        if (coffeesExtra.name == "Select the amount of sugar") {
            coffeesExtra.name = "Sugar"
        }
        if (coffeesExtra.name == "Select type of milk") {
            coffeesExtra.name = "Milk"
        }
        
        cell.selectedBackgroundView = UIView()
        cell.coffeeImageView.image = UIImage(named:coffeesExtra.name)
        cell.coffeeLabel.text = coffeesExtra.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = coffeesExtra[indexPath.row]
        selectedExtrasIds.append(selected.id)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deSelected = coffeesExtra[indexPath.row]
        selectedExtrasIds.remove(at: selectedExtrasIds.firstIndex(of: deSelected.id) ?? -1)
    }
    
    @objc func presentView() {
        defaults.set(selectedExtrasIds, forKey: "ExtrasIds")
        
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "OverviewViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func presentPreviousView(){
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "SizeViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }

}
