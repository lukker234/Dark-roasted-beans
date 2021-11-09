//
//  StyleViewController.swift
//  Dark roasted beans
//
//  Created by Luc Daalmeijer on 06/11/2021.
//

import UIKit
import Combine
import SwiftUI

class StyleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var coffeeSubscribers: AnyCancellable?
    let defaults = UserDefaults.standard
    @Published var coffees = [Coffee]()
    
    private var coffeesType = [Coffee.CoffeeType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        fetchCoffeesTypes()
    }
    
    private func fetchCoffeesTypes() {
        coffeeSubscribers = NetworkManager().coffeePublisher
            .sink(receiveCompletion: { _ in}, receiveValue: { (coffees) in
                for coffeeType in coffees.types {
                    self.coffeesType.append(coffeeType)
                }
            })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeesType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StyleCell") as! CoffeeTableViewCell
        let coffeeTypes = self.coffeesType[indexPath.item]
        cell.coffeeLabel.text = coffeeTypes.name
        cell.coffeeImageView.image = UIImage(named:coffeeTypes.name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = coffeesType[indexPath.row]
        defaults.set(selected.id, forKey: "CoffeeTypeId")
        presentView()
    }
    
    func presentView() {
        let newViewController = self.storyboard!.instantiateViewController(withIdentifier: "SizeViewController")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}
