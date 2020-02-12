//
//  ViewController.swift
//  DiffableDataSourceTableView
//
//  Created by Suresh Shiga on 12/02/20.
//  Copyright © 2020 Suresh Shiga. All rights reserved.
//

import UIKit

//Mark:- Data Model

struct Device: Hashable {
    let name:String
}

let devices = [
Device(name: "iPhone5"),
Device(name: "iPhone6"),
Device(name: "iPhone7"),
Device(name: "iPhone8"),
Device(name: "iPhoneX"),
Device(name: "iPhoneXR")
]


//Mark:- Section Enum

extension ViewController {
    fileprivate enum Section {
        case One
    }
}

//Mark:- typealias DataSource & SnapShot

fileprivate typealias DeviceDiffableDataSource         = UITableViewDiffableDataSource<ViewController.Section, Device>
fileprivate typealias DeviceDiffableDataSourceSnapShot = NSDiffableDataSourceSnapshot<ViewController.Section, Device>

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier: String = "cell"
    private var dataSource: DeviceDiffableDataSource!
    private var snapShot = DeviceDiffableDataSourceSnapShot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        configureDataSource()
    }

    private func configureDataSource() {
        dataSource = DeviceDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, device) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
            cell.textLabel?.text = device.name
            return cell
        })
        
        createSnapShot()
    }
    
    private func createSnapShot() {
        snapShot.deleteAllItems()
        snapShot.appendSections([Section.One])
        snapShot.appendItems(devices)
        
        self.dataSource.apply(self.snapShot, animatingDifferences: true)
    }

}

