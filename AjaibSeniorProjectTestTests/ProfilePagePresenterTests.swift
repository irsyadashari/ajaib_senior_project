//
//  ProfilePagePresenterTests.swift
//  AjaibSeniorProjectTestTests
//
//  Created by Muh Irsyad Ashari on 12/03/24.
//

import XCTest
@testable import AjaibSeniorProjectTest

final class ProfilePagePresenterTests: XCTestCase {
    var sut: ProfilePagePresenter!
    
    override func setUp() {
        sut = ProfilePagePresenter()
    }

    func testViewDidLoad_WhenLoadProfilePage_ThenLoadValueProperly() {
        //When
        sut.viewDidLoad()
        
        //Then
        let userInfoCellViewParam = sut.getProfileViewParam()
        XCTAssertEqual(userInfoCellViewParam.name, "Magicians")
        XCTAssertEqual(userInfoCellViewParam.isVerified, true)
        
        let paymentModel = sut.getPaymentViewParam()
        XCTAssertEqual(paymentModel.titleBalance, "Saldo")
        XCTAssertEqual(paymentModel.titleInProcessBalance, "Saldo di Proses")
        XCTAssertEqual(paymentModel.valueBalance, "Rp 1,500,000")
        XCTAssertEqual(paymentModel.valueInProcessBalance, "Rp 20,000")
        
        let bannerModel = sut.getCarouselPresenter()
        XCTAssertEqual(bannerModel?.colors.count, 3)
    }
}
