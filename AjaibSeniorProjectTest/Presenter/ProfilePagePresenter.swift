//
//  ProfilePagePresenter.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

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
    
    func getCarouselPresenter() -> CarouselViewPresenter {
        return CarouselViewPresenter(colors: [
            "#047d24", "#1d74f5", "#e61049" // for testing multiple items
//            "#047d24" // for testing single item
        ])
    }
    
    func getPaymentViewParam() -> PaymentCellViewParam {
        return PaymentCellViewParam(
            titleBalance: "Saldo",
            valueBalance: "Rp.1.000.000",
            titleInProcessBalance: "Saldo di Proses",
            valueInProcessBalance: "Rp.20000")
    }
    
    func getProfileViewParam() -> UserInfoCellViewParam {
        return UserInfoCellViewParam(name: "Irsyad Ashari", image: UIImage(named: "icon-profile-default"), isVerified: true)
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
