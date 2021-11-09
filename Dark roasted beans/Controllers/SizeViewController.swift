//
//  SizeViewController.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 08/11/2021.
//

import UIKit
import Combine

class SizeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    private var coffeeSubscribers: AnyCancellable?
    var selectedCoffeeTypeId = UserDefaults.standard.object(forKey: "CoffeeTypeId") as! String
    let defaults = UserDefaults.standard
    
    private var coffeesSize = [Coffee.CoffeeSize]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoffeesSizes()
        setupBackButton()
    }
    
    private func fetchCoffeesSizes() {
        coffeeSubscribers = NetworkManager().coffeePublisher
            .sink(receiveCompletion: { _ in}, receiveValue: { (coffees) in
                for coffeeType in coffees.types {
                    if (coffeeType.id == self.selectedCoffeeTypeId) {
                        for coffeeSize in coffeeType.sizes {
                            for coffeesSize in coffees.sizes {
                                if coffeesSize.id == coffeeSize {
                                    self.coffeesSize.append(coffeesSize)
                                }
                            }
                        }
                    }
                }
            })
    }
    
    func setupBackButton(){
        backButton.addTarget(self, action: #selector(presentPreviousView), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeesSize.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeCell") as! CoffeeTableViewCell
        let coffeesSize = self.coffeesSize[indexPath.item]
        cell.coffeeLabel.text = coffeesSize.name
        cell.coffeeImageView.image = UIImage(named:coffeesSize.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = coffeesSize[indexPath.row]
        defaults.set(selected.id, forKey: "SizeId")
        presentView()
    }
    
    func presentView() {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "ExtrasViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func presentPreviousView(){
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "StyleViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
