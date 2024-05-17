//
//  ProfilePagePresenter.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit
import RxSwift
import RxCocoa

enum CellType {
    case profile
    case payment
    case cta
    case promotion
    case setting
    case system
    case logout
    case spacing
}

final class ProfilePagePresenter {
    var sections: [CellType] = []
    private var profileModel: UserDomainModel?
    private var paymentModel: PaymentDomainModel?
    private var bannerModel: CTADomainModel?
    
    private let disposeBag = DisposeBag()
    
    init() {
        sections = [
            .profile,
            .spacing,
            .payment,
            .spacing,
            .cta,
            .spacing,
            .promotion,
            .spacing,
            .setting,
            .spacing,
            .system,
            .spacing,
            .logout
        ]
    }
    
    func viewDidLoad() {
       loadSections()
    }
    
    private func loadSections() {
//        For testing verified users
        MockAPIService.getUserVerified().asObservable()
            .subscribe(onNext: { [weak self] model in
                self?.profileModel = UserDomainModel(name: model.name, isVerified: model.isVerified)

                if model.isVerified {
                    self?.loadCTABanners()
                }
            }).disposed(by: disposeBag)
        
        //For testing Not verified users
//        MockAPIService.getUserNotVerified().asObservable()
//            .subscribe(onNext: { [weak self] model in
//                self?.profileModel = UserDomainModel(name: model.name, isVerified: model.isVerified)
//                
//                if model.isVerified {
//                    self?.loadCTABanners()
//                }
//            }).disposed(by: disposeBag)
        
        MockAPIService.getPayments().asObservable()
            .subscribe(onNext: { [weak self] model in
                self?.paymentModel = PaymentDomainModel(balance: model.balance, inProcessBalance: model.inProcessBalance)
            }).disposed(by: disposeBag)
    }
    
    private func loadCTABanners() {
        //for testing multiple banners
        MockAPIService.getBanners().asObservable()
            .subscribe(onNext: { [weak self] model in
                self?.bannerModel = CTADomainModel(banners: model.banners)
            }).disposed(by: disposeBag)
        
        //for testing single banners
//        MockAPIService.getSingleBanners().asObservable()
//            .subscribe(onNext: { [weak self] model in
//                self?.bannerModel = CTADomainModel(banners: model.banners)
//            }).disposed(by: disposeBag)
    }
    
    func getProfileViewParam() -> UserInfoCellViewParam {
        if let profileModel {
            return UserInfoCellViewParam(name: profileModel.name, image: UIImage(named: "icon-profile-default"), isVerified: profileModel.isVerified)
        }
        return UserInfoCellViewParam(name: "No User Found", image: UIImage(named: "icon-profile-default"), isVerified: false)
    }
    
    func getPaymentViewParam() -> PaymentCellViewParam {
        let balanceText = StringFormatter.getCurrencyDisplayedText(number: self.paymentModel?.balance ?? 0)
        let inProcessBalanceText = StringFormatter.getCurrencyDisplayedText(number: self.paymentModel?.inProcessBalance ?? 0)
        return PaymentCellViewParam(
            titleBalance: "Saldo",
            valueBalance: balanceText,
            titleInProcessBalance: "Saldo di Proses",
            valueInProcessBalance: inProcessBalanceText
        )
    }
    
    func getCarouselPresenter() -> CarouselViewPresenter? {
        guard let bannerModel else { return nil }
        return CarouselViewPresenter(colors: bannerModel.banners)
    }
    
    func generatePromotionCellParam() -> [OptionCellViewParam] {
        let params: [OptionCellViewParam] = [
            OptionCellViewParam(
                title: "Referral",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.cta
            ),
            OptionCellViewParam(
                title: "Invitation",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.cta
            )
        ]
        return params
    }
    
    func generateSystemCellParam() -> [OptionCellViewParam] {
        let params: [OptionCellViewParam] = [
            OptionCellViewParam(
                title: "Vers",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.text(text: "App Version 4.71")
            ),
            OptionCellViewParam(
                title: "Legal",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.cta
            )
        ]
        return params
    }
    
    func generateSettingCellParam() -> [OptionCellViewParam] {
        let params: [OptionCellViewParam] = [
            OptionCellViewParam(
                title: "Notification",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.cta
            ),
            OptionCellViewParam(
                title: "Dark Mode",
                image: UIImage(named: "diamond-points"),
                cellType: OptionViewType.toggle
            ),
        ]
        return params
    }
}
