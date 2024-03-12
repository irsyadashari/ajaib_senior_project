//
//  ProfilePageViewController.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfilePageViewController: UIViewController {
    let presenter = ProfilePagePresenter()
    private lazy var tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        title = "Profile Page"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.pinCenter(to: view, distance: 16)
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(LogoutCell.self, forCellReuseIdentifier: LogoutCell.reuseIdentifier)
        tableView.register(SystemCell.self, forCellReuseIdentifier: SystemCell.reuseIdentifier)
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.register(PromotionCell.self, forCellReuseIdentifier: PromotionCell.reuseIdentifier)
        tableView.register(UserInfoViewCell.self, forCellReuseIdentifier: UserInfoViewCell.reuseIdentifier)
        tableView.register(PaymentViewCell.self, forCellReuseIdentifier: PaymentViewCell.reuseIdentifier)
        tableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.reuseIdentifier)
    }
    
    private func goToDetailPage() {
        let detailPage = DetailViewController()
        detailPage.view.backgroundColor = .systemBackground
        detailPage.title = "Detail Page"
        navigationController?.pushViewController(detailPage, animated: true)
    }
    
    private func toggleDarkMode(isOn: Bool) {
        var theme = Theme.light
        if isOn {
            theme = Theme.dark
        }
        UserDefaults.standard.setValue(theme.rawValue, forKey: "theme")
    }
    
    private func promptLogout() {
        // Create an alert controller
        let alertController = UIAlertController(title: "Logout", message: "Are you sure ?", preferredStyle: .alert)
        
        let actionLogout = UIAlertAction(title: "Logout", style: .default) { (action) in
            print("Logout pressed")
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            print("Cancel pressed")
        }
        
        alertController.addAction(actionLogout)
        alertController.addAction(actionCancel)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
}

extension ProfilePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch presenter.sections[indexPath.row] {
        case .logout:
            promptLogout()
        default:
            print("please click on the chevron logo")
        }
    }
}

extension ProfilePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.sections[indexPath.row] {
        case .cta:
            guard let carouselPresenter = presenter.getCarouselPresenter() else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CarouselTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! CarouselTableViewCell
            cell.configure(presenter: carouselPresenter)
            return cell
        case .profile:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: UserInfoViewCell.reuseIdentifier,
                for: indexPath
            ) as! UserInfoViewCell
            cell.configure(viewParam: presenter.getProfileViewParam())
            return UITableViewCell()
        case .payment:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PaymentViewCell.reuseIdentifier,
                for: indexPath
            ) as! PaymentViewCell
            cell.configure(viewParam: presenter.getPaymentViewParam())
            return cell
        case .promotion:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PromotionCell.reuseIdentifier,
                for: indexPath
            ) as! PromotionCell
            let params = presenter.generatePromotionCellParam()
            cell.configure(viewParams: params)
            cell.rxEventChevronDidTapped.asObservable()
                .subscribe(onNext: { [weak self] in
                    self?.goToDetailPage()
                }).disposed(by: disposeBag)
            return cell
        case .setting:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingCell.reuseIdentifier,
                for: indexPath
            ) as! SettingCell
            let params = presenter.generateSettingCellParam()
            cell.configure(viewParams: params)
            cell.rxEventToggleDidSwitched.asObservable()
                .subscribe(onNext: { [weak self] isOn in
                    self?.toggleDarkMode(isOn: isOn)
                }).disposed(by: disposeBag)
            cell.rxEventChevronDidTapped.asObservable()
                .subscribe(onNext: { [weak self] in
                    self?.goToDetailPage()
                }).disposed(by: disposeBag)
            return cell
        case .system:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SystemCell.reuseIdentifier,
                for: indexPath
            ) as! SystemCell
            let params = presenter.generateSystemCellParam()
            cell.configure(viewParams: params)
            cell.rxEventChevronDidTapped.asObservable()
                .subscribe(onNext: { [weak self] in
                    self?.goToDetailPage()
                }).disposed(by: disposeBag)
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LogoutCell.reuseIdentifier,
                for: indexPath
            ) as! LogoutCell
            cell.configure()
            return cell
        case .spacing:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch presenter.sections[indexPath.row] {
        case .profile:
            return 60
        case .payment:
            return 140
        case .cta:
            if presenter.getCarouselPresenter()?.colors.count ?? 0 < 1 {
                return 0
            }
        return 100
        case .promotion:
            return 135
        case .setting:
            return 140
        case .system:
            return 135
        case .logout:
            return 40
        case .spacing:
            return 8
        }
    }
}
