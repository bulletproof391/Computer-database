//
//  ViewController.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 01.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewRefreshing {
    
    // MARK: - Public Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currentPageLabel: UILabel!
    var viewModel: MainScreenViewModel! {
        didSet {
            viewModel.delegate = self
            viewModel.getList(page: viewModel.currentPage)
        }
    }

    // MARK: - Private Properties
    private let reuseIdentifier = "MainScreenCell"
    
    @IBOutlet var previousPageButton: UIBarButtonItem!
    @IBOutlet var nextPageButton: UIBarButtonItem!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    
    // MARK: - Buttons handling
    @IBAction func nextPage(_ sender: Any) {
        viewModel.currentPage += 1
        viewModel.getList(page: viewModel.currentPage)
    }
    
    @IBAction func previousPage(_ sender: Any) {
        viewModel.currentPage -= 1
        viewModel.getList(page: viewModel.currentPage)
    }
    
    
    // MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = viewModel.textForRowAt(indexPath: indexPath)
        cell.detailTextLabel?.text = viewModel.detailTextForRowAt(indexPath: indexPath)
        
        return cell
    }
    
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = GoodsViewController()
        if let detailViewModel = viewModel.detailViewModelAt(indexPath: indexPath) {
            viewController.viewModel = detailViewModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    // MARK: - Table View Refreshing
    func updateScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            weakSelf.previousPageButton.isEnabled = true
            weakSelf.nextPageButton.isEnabled = true
            weakSelf.currentPageLabel.text = "\(weakSelf.viewModel.currentPage + 1) of \(weakSelf.viewModel.lastPage)"
        }
    }
    
    func updateToolbarButtons() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            
            if weakSelf.viewModel.currentPage == 0 {
                weakSelf.previousPageButton.isEnabled = false
            } else {
                weakSelf.nextPageButton.isEnabled = false
            }
        }
    }

    
    // MARK: - Private Methods
    private func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func initializeViewController() {
        navigationItem.title = "Computer database"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        previousPageButton.isEnabled = false
        initializeTableView()
    }
}

