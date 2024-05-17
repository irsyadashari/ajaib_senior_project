//
//  DetailInteractor.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation

final class DetailInteractor {
    var investmentDuration: InvestmentDuration = .sixMonth
    var marketPrice: Double = 0.0
    var totalInvestment: Double = 0.0
    var roi: Double = 0.0
    
    func setInvestmentDuration(investmentDuration: InvestmentDuration) {
        self.investmentDuration = investmentDuration
    }
    
    func getMarketPriceText(number: Double) -> String {
        setMarketPrice(price: number)
        return StringFormatter.getCurrencyText(number: number)
    }
    
    func getYearlyProjectionText(number: Double) -> String {
        return StringFormatter.getDecimalText(number: number)
    }
    
    func getInvestmentUnitText(number: Double) -> String {
        return StringFormatter.getDecimalText(number: number)
    }
    
    func getDateText(date: Date) -> String {
        return StringFormatter.getDisplayedDate(date: date)
    }
    
    func getDateEndText(date: Date) -> String {
        var dateContainer = date
        switch investmentDuration {
        case .sixMonth:
            if let newDate = Calendar.current.date(byAdding: .month, value: 6, to: dateContainer) {
                dateContainer = newDate
            }
        case .oneYear:
            if let newDate = Calendar.current.date(byAdding: .year, value: 1, to: dateContainer) {
                dateContainer = newDate
            }
        case .threeYear:
            if let newDate = Calendar.current.date(byAdding: .year, value: 3, to: dateContainer) {
                dateContainer = newDate
            }
        case .fiveYear:
            if let newDate = Calendar.current.date(byAdding: .year, value: 5, to: dateContainer) {
                dateContainer = newDate
            }
        }
        return StringFormatter.getDisplayedDate(date: dateContainer)
    }
    
    func getTotalInvestmentText(
        yearlyProjection: Double,
        investmentUnit: Double
    ) -> String {
        let estimatedReturn: Double = investmentDuration.duration
        let totalInvestment: Double =  (marketPrice * yearlyProjection * investmentUnit * estimatedReturn) + marketPrice
        self.totalInvestment = totalInvestment
        let currencyNumberString = StringFormatter.getCurrencyText(number: totalInvestment)
        return "\(currencyNumberString)"
    }
    
    func getRoiText() -> String {
        let roi = totalInvestment - marketPrice
        let currencyNumberString = StringFormatter.getCurrencyText(number: roi)
        return "ROI: \(currencyNumberString)"
    }
    
    private func setMarketPrice(price: Double) {
        self.marketPrice = price
    }
}
