//
//  ProfilePageViewController.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

final class ProfilePageViewController: UIViewController {
    let presenter = ProfilePagePresenter()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
    }
    
    private func setupView() {
        title = "Profile Page"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pin(to: view)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc func goToDetailPage() {
        let detailPage = UIViewController()
        detailPage.title = "Detail Page"
        navigationController?.pushViewController(detailPage, animated: true)
        
    }
    
}

extension ProfilePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell at \(indexPath.row) is tapped")
    }
}

extension ProfilePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch presenter.sections[indexPath.row] {
        case .cta:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return UITableViewCell()
        case .profile:
            return UITableViewCell()
        case .payment:
            return UITableViewCell()
        case .optionList:
            return UITableViewCell()
        }
        
        
    }


}
