//
//  VenuesListController.swift
//  Mahzen
//
//  Created by Said Ozcan on 23/12/2017.
//  Copyright © 2017 SaidOzcan. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import FirebaseRemoteConfig

class VenuesListController: UIViewController {
    // MARK: Properties
    fileprivate let presenter: VenuesListPresenter
    fileprivate let remoteConfigManager: RemoteConfigManager
    fileprivate let imageDownloadingManager: ImageDownloadingManager
    fileprivate let listStyleToLayoutVenues: String?
    
    fileprivate lazy var tableViewDataSource : VenuesListTableDataSource = { [unowned self] in
        return VenuesListTableDataSource(tableView: tableView, imageDownloadingManager: imageDownloadingManager)
    }()
    fileprivate lazy var collectionViewDataSource: VenuesListCollectionViewDataSource = { [unowned self] in
       return VenuesListCollectionViewDataSource(collectionView: collectionView, imageDownloadingManager: imageDownloadingManager)
    }()
    
    // MARK: IBOutlets
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = Defines.Sizes.defaultVenueTableCellHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = Defines.Colors.white
        tableView.backgroundView = nil
        tableView.tableHeaderView = UIView()
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    fileprivate lazy var tableViewConstraints: [NSLayoutConstraint] = {
        return [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.frame.size.width - (Defines.Metrics.Spacings.double)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 350)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Defines.Colors.white
        
        return collectionView
    }()
    
    fileprivate lazy var collectionViewConstraints: [NSLayoutConstraint] = {
        return [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Defines.Metrics.Spacings.double),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Defines.Metrics.Spacings.double),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
    }()
    
    // MARK: Lifecycle
    init(presenter: VenuesListPresenter, imageDownloadingManager: ImageDownloadingManager, remoteConfigManager: RemoteConfigManager) {
        self.presenter = presenter
        self.remoteConfigManager = remoteConfigManager
        self.imageDownloadingManager = imageDownloadingManager
        self.listStyleToLayoutVenues = remoteConfigManager.experimentValue(for: RemoteConfigKey.venuesListStyle.rawValue)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        setupDataSources()
        
        presenter.fetchVenues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Private
    fileprivate func setupUI() {
        title = remoteConfigManager.experimentValue(for: RemoteConfigKey.venuesListTitle.rawValue)
        view.backgroundColor = Defines.Colors.white
        
        print(remoteConfigManager.experimentValue(for: RemoteConfigKey.venuesListTitle.rawValue))
        print(remoteConfigManager.experimentValue(for: RemoteConfigKey.venuesListStyle.rawValue))
        
        if "list" == listStyleToLayoutVenues {
            view.addSubview(tableView)
            NSLayoutConstraint.activate(tableViewConstraints)
        } else {
            view.addSubview(collectionView)
            NSLayoutConstraint.activate(collectionViewConstraints)
        }
    }
    
    fileprivate func setupDataSources() {
        if "list" == listStyleToLayoutVenues {
            tableView.delegate = tableViewDataSource
            tableView.dataSource = tableViewDataSource
            tableView.prefetchDataSource = tableViewDataSource
        } else {
            collectionView.dataSource = collectionViewDataSource
            collectionView.delegate = collectionViewDataSource
        }
    }
    
    @objc fileprivate func refresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.presenter.fetchVenues()
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: Public
    func show(venues: [Venue]) {
        if "list" == listStyleToLayoutVenues {
            tableViewDataSource.update(with: venues)
            tableView.reloadData()
        } else {
            collectionViewDataSource.update(with: venues)
            collectionView.reloadData()
        }
    }
}
