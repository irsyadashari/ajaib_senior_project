//
//  DetailViewPresenterTests.swift
//  AjaibSeniorProjectTestTests
//
//  Created by Muh Irsyad Ashari on 12/03/24.
//

import XCTest
@testable import AjaibSeniorProjectTest

final class DetailViewPresenterTests: XCTestCase {
    var sut: DetailViewPresenter!
    
    override func setUp() {
        sut = DetailViewPresenter()
    }
    
    func testViewDidLoad_WhenLoadDetailPageFirstTime_ThenGenerateMarketPriceTextCorrectlyAccordingToLoadedAPIMarketPrice() {
        //When
        sut.viewDidLoad()
        
        //Then
        let marketPriceText = sut.getMarketPriceText(numberTextField: 125000, isInitial: true)
        XCTAssertEqual(marketPriceText, "Rp 2,912.06")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateMarketPriceTextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let marketPriceText = sut.getMarketPriceText(numberTextField: 125000, isInitial: false)
        XCTAssertEqual(marketPriceText, "Rp 1,250.00")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateROITextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let roiText = sut.getRoiText()
        XCTAssertEqual(roiText, "ROI: Rp 0.00")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateTotalInvestmentValueTextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let totalInvestmentValueText = sut.getTotalInvestmentValueText()
        XCTAssertEqual(totalInvestmentValueText, "Rp 0.00")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateDateEndTextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let dateEndText = sut.getDateEndText()
        XCTAssertEqual(dateEndText, "5 May 2024")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateDateStartTextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let dateStartText = sut.getdateStartText()
        XCTAssertEqual(dateStartText, "5 Nov 2023")
    }
    
    func testViewDidLoad_WhenDetailPageMarketPriceIsChangeByUser_ThenGenerateTotalInvestmentDateTextCorrectlyAccordingToUserInput() {
        //When
        sut.viewDidLoad()
        
        //Then
        let totalInvestmentDateText = sut.getTotalInvestmentDateText()
        XCTAssertEqual(totalInvestmentDateText, "From 5 Nov 2023 to 5 May 2024")
    }
    
    func testViewDidLoad_WhenDetailPageIsLoaded_ThenGenerateYearlyProjectionText() {
        //When
        sut.viewDidLoad()
        
        //Then
        let yearlyProjectionText = sut.getYearlyProjectionText()
        XCTAssertEqual(yearlyProjectionText, "0,083")
    }
    
    func testViewDidLoad_WhenDetailPageIsLoaded_ThenGenerateInvestmentUnitText() {
        //When
        sut.viewDidLoad()
        
        //Then
        let investmentUnitText = sut.getInvestmentUnitText()
        XCTAssertEqual(investmentUnitText, "0,530")
    }
    
    func testViewDidLoad_WhenUserChangeInvestmentDuration_ThenSetInvestmentDuration() {
        //When
        sut.viewDidLoad()
        sut.didUserChangeInvestmentDuration(duration: .threeYear)
        
        //Then
        let investmentDuration: InvestmentDuration = sut.interactor.investmentDuration
        XCTAssertEqual(investmentDuration, .threeYear)
    }
}
