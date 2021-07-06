//
//  ViewController.swift
//  Shopping-List(P4-P6)
//
//  Created by Łukasz Nycz on 06/07/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your Shopping List:"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
        
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        let shareIcon = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        navigationItem.rightBarButtonItems = [addItem, shareIcon]
    }

    
    @objc func refreshList() {
        let ac = UIAlertController(title: "Clear your list?", message: "Remove all items from your list?", preferredStyle: .alert)
        
        let clear = UIAlertAction(title: "Remove all", style: .cancel) { (UIAlertAction) in
            self.shoppingList.removeAll(keepingCapacity: true)
            self.tableView.reloadData()
        }
        ac.addAction(clear)
        present(ac, animated: true)
    }
    
    @objc func addItems() {
        let ac = UIAlertController(title: "Enter Your Items", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func submit(_ item:String) {
        let lowerItem = item.lowercased()
        
        shoppingList.insert(lowerItem, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    

}
