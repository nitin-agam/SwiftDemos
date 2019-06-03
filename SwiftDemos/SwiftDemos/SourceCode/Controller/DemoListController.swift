//
//  ViewController.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/05/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import UIKit

class DemoListController: UITableViewController {
    
    // MARK: - Variables
    private let kCellIdentifier = "ListCell"
    private let listArray = ["Alamofire Demo"]
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swift Demos"
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        log.method("\(LogManager.stats()) Demo list shown !!")/
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        log.other("\(LogManager.stats()) Moving to a demo !!")/
        switch indexPath.row {
        case 0:
            let controller = APIRequestDemoController()
            controller.title = listArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
            
        default: break
        }
    }
    
}

