//
//  ViewController.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Public Properties
    @IBOutlet var tableView: UITableView!
    var viewModel: MainScreenViewModel! {
        didSet {
//            viewModel.getList(page: 1)
            viewModel.getRelatedWith(6)
        }
    }
    
    // MARK: - Private Properties
    private let reuseIdentifier = "MainScreenCell"
    
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = "Cell title"
        cell.detailTextLabel?.text = "Description"
        
        return cell
    }


    
    // MARK: - Private Methods
    private func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func initializeViewController() {
        navigationItem.title = "Computer database"
        initializeTableView()
    }
}

