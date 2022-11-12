//
//  MainNewsViewController.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import UIKit

class MainNewsViewController: UIViewController {
    // Properties
    private let viewModel = MainNewsViewModel()
    var tableView: UITableView!
    var searchBar: UISearchBar!
    
    override func loadView() {
        setInitialState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        registerCell()
        bind()
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func registerCell() {
        tableView.register(MainNewsTableViewCell.self, forCellReuseIdentifier: MainNewsTableViewCell.identifier)
    }
    
    private func bind() {
        viewModel.onFetchedData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: -Layout
extension MainNewsViewController {
    
    private func setInitialState() {
        view = UIView()
        view.backgroundColor = .white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 170,
                                              width: UIScreen.main.bounds.size.width,
                                              height: UIScreen.main.bounds.size.height))
        view.addSubview(tableView)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 70,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 100))
        view.addSubview(searchBar)
    }
}

// MARK: - Delegates
extension MainNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource[viewModel.headlines[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.headlines[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        310
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainNewsTableViewCell.identifier, for: indexPath) as! MainNewsTableViewCell
        let headline = viewModel.headlines[indexPath.section]
        if let dataModel = viewModel.dataSource[headline] {
            let model = viewModel.getMainNewsCellModel(from: dataModel[indexPath.row])
            cell.setModel(model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebPreiewViewController()
        vc.urlString = Array(viewModel.dataSource)[indexPath.section].value[indexPath.row].url
        RoutingService.shared.currentNavigationStackRoot?.pushViewController(vc, animated: true)
    }
}

extension MainNewsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterNews(with: searchText)
    }
}
