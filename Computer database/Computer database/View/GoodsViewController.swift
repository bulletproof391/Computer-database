//
//  GoodsViewController.swift
//  Computer database
//
//  Created by Дмитрий Вашлаев on 02.09.18.
//  Copyright © 2018 Дмитрий Вашлаев. All rights reserved.
//

import UIKit

class GoodsViewController: UIViewController, DetailViewRefreshing, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Public Properties
    var viewModel: DetailViewModel! {
        didSet {
            viewModel.delegate = self
            viewModel.getInfo()
        }
    }
    
    let scrollView: UIScrollView = {
        let newScrollView = UIScrollView()
        newScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return newScrollView
    }()
    
    let contentView: UIView = {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        
        label.text = "N/A"
        return label
    }()
    
    let companyNameSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.darkGray
        
        label.text = "Company"
        return label
    }()
    
    let introduced: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        label.text = "N/A"
        return label
    }()
    
    let introducedSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.darkGray
        
        label.text = "Introduced"
        return label
    }()
    
    let discounted: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        label.text = "N/A"
        return label
    }()
    
    let discountedSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.darkGray
        
        label.text = "Discounted"
        return label
    }()

    let goodsDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        
        label.text = "N/A"
        return label
    }()
    
    let goodsDescriptionSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.darkGray
        
        label.text = "Description"
        return label
    }()
    
    let image: UIImageView = {
        let newImageView = UIImageView()
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        newImageView.backgroundColor = UIColor.lightGray
        newImageView.contentMode = .scaleAspectFill
        newImageView.clipsToBounds = true
        
        return newImageView
    }()
    
    let tableViewSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        
        label.text = "You must be looking for:"
        return label
    }()
    
    let tableView: UITableView = {
        let newTableView = UITableView()
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        return newTableView
    }()
    
    let reuseIdentifier = "cell"
    
    // MARK: - Private Properties
    private lazy var imageSize: CGFloat = {
        var size: CGFloat = 0
        
        switch UIDevice.current.orientation {
        case .portrait:
            size = UIScreen.main.bounds.width
        case .portraitUpsideDown:
            size = UIScreen.main.bounds.width
        default:
            size = UIScreen.main.bounds.height
        }
        
        return size
    }()
    
    // MARK: - Public Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    
    // MARK: - Detail View Refreshing
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            
            if let _ = weakSelf.viewModel.companyName {
                weakSelf.companyName.text = weakSelf.viewModel.companyName
            }
            
            if let _ = weakSelf.viewModel.discounted {
                weakSelf.discounted.text = weakSelf.viewModel.discounted
            }
            
            if let _ = weakSelf.viewModel.introduced {
                weakSelf.introduced.text = weakSelf.viewModel.introduced
            }
            
            if let _ = weakSelf.viewModel.goodsDescription {
                weakSelf.goodsDescription.text = weakSelf.viewModel.goodsDescription
            }
        }
    }
    
    func updateImage() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.image.image = weakSelf.viewModel.image
        }
        
    }
    
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    
    // MARK: - Private Methods
    private func initializeViewController() {
        view.backgroundColor = UIColor.white
        navigationItem.title = viewModel?.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        addViews()
        initializeTableView()
    }
    
    private func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(companyName)
        contentView.addSubview(companyNameSubtitle)
        contentView.addSubview(introduced)
        contentView.addSubview(introducedSubtitle)
        contentView.addSubview(discounted)
        contentView.addSubview(discountedSubtitle)
        contentView.addSubview(goodsDescription)
        contentView.addSubview(goodsDescriptionSubtitle)
        contentView.addSubview(image)
        contentView.addSubview(tableViewSubtitle)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
        NSLayoutConstraint.activate([contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
                                     contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     contentView.heightAnchor.constraint(equalToConstant: 900)])
        
        
        NSLayoutConstraint.activate([companyName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     companyName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     companyName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([companyNameSubtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     companyNameSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     companyNameSubtitle.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([introduced.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     introduced.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     introduced.topAnchor.constraint(equalTo: companyNameSubtitle.bottomAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([introducedSubtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     introducedSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     introducedSubtitle.topAnchor.constraint(equalTo: introduced.bottomAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([discounted.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     discounted.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     discounted.topAnchor.constraint(equalTo: introducedSubtitle.bottomAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([discountedSubtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     discountedSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     discountedSubtitle.topAnchor.constraint(equalTo: discounted.bottomAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([goodsDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     goodsDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     goodsDescription.topAnchor.constraint(equalTo: discountedSubtitle.bottomAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([goodsDescriptionSubtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     goodsDescriptionSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     goodsDescriptionSubtitle.topAnchor.constraint(equalTo: goodsDescription.bottomAnchor, constant: 3)])
        
        NSLayoutConstraint.activate([image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     image.topAnchor.constraint(equalTo: goodsDescriptionSubtitle.bottomAnchor, constant: 8),
                                     image.widthAnchor.constraint(equalToConstant: imageSize - 32),
                                     image.heightAnchor.constraint(equalToConstant: imageSize - 32)])
        
        NSLayoutConstraint.activate([tableViewSubtitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     tableViewSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     tableViewSubtitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     tableView.topAnchor.constraint(equalTo: tableViewSubtitle.bottomAnchor, constant: 3),
                                     tableView.heightAnchor.constraint(equalToConstant: 250)])
    }
}
