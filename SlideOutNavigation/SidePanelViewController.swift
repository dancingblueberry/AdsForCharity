//
//  SidePanelViewController.swift
//  AdsForCharity
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
  func menuItemSelected(menuItem: MenuItem)
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var menuItems: Array<MenuItem>!
    var delegate: SidePanelViewControllerDelegate?
    
    struct TableView {
        struct CellIdentifiers {
            static let MenuItemCell = "AnimalCell"
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuItemCell, forIndexPath: indexPath) as AnimalCell
        cell.configureForMenuItem(menuItems[indexPath.row])
        return cell
    }
    
    // Mark: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedMenuItem = menuItems[indexPath.row]
        delegate?.menuItemSelected(selectedMenuItem)
    }
    
}

class AnimalCell: UITableViewCell {
    @IBOutlet weak var menuItemImageView: UIImageView!
//    @IBOutlet weak var imageNameLabel: UILabel!
  
    func configureForMenuItem(menuItem: MenuItem) {
        menuItemImageView.image = menuItem.image
//        imageNameLabel.text = menuItem.title
    }
}