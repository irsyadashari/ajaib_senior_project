//
//  DetailViewPresenter.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 09/03/24.
//

import Foundation
import RxSwift

final class DetailViewPresenter {
    var simulationModel: SimulationDomainModel? = nil
    
    let rxEventSimulationViewParamLoaded = PublishSubject<Void>()
    
    let interactor = DetailInteractor()
    
    private let disposeBag = DisposeBag()
    
    func viewDidLoad() {
        loadSimulationData()
    }
    
    func didUserChangeInvestmentDuration(duration: InvestmentDuration) {
        interactor.setInvestmentDuration(investmentDuration: duration)
    }
    
    func getMarketPriceText(numberTextField: Double, isInitial: Bool) -> String {
        if isInitial {
            let marketPrice: Double = simulationModel?.marketPrice ?? 0.0
            return interactor.getMarketPriceText(number: marketPrice)
        }
        
        return interactor.getMarketPriceText(number: numberTextField)
    }
    
    func getYearlyProjectionText() -> String {
        let yearlyProjection: Double = simulationModel?.yearlyProjection ?? 0.0
        return interactor.getYearlyProjectionText(number: yearlyProjection)
    }
    
    func getInvestmentUnitText() -> String {
        let qtyOwned: Double = simulationModel?.qtyOwned ?? 0.0
        return interactor.getInvestmentUnitText(number: qtyOwned)
    }
    
    func getTotalInvestmentDateText() -> String {
        let startDate = getdateStartText()
        let endDate = getDateEndText()
        return "From \(startDate) to \(endDate)"
    }
    
    func getdateStartText() -> String {
        let investmentDate: Date = simulationModel?.investmentDate ?? Date()
        return interactor.getDateText(date: investmentDate)
    }
    
    func getDateEndText() -> String {
        let dateStart: Date = simulationModel?.investmentDate ?? Date()
        return interactor.getDateEndText(date: dateStart)
    }
    
    func getTotalInvestmentValueText() -> String {
        let yearlyProjection: Double = simulationModel?.yearlyProjection ?? 0.0
        let investmentUnit: Double = simulationModel?.qtyOwned ?? 0.0
        
        return interactor.getTotalInvestmentText(
            yearlyProjection: yearlyProjection,
            investmentUnit: investmentUnit
        )
    }
    
    func getRoiText() -> String {
        return interactor.getRoiText()
    }
    
    private func loadSimulationData() {
        MockAPIService.getSimulationDomainModel().asObservable()
            .subscribe(onNext: { [weak self] dataModel in
                self?.simulationModel = dataModel
                self?.rxEventSimulationViewParamLoaded.onNext(())
            }).disposed(by: disposeBag)
    }
}

final class DetailInteractor {
    var investmentDuration: InvestmentDuration = .sixMonth
    var marketPrice: Double = 0.0
    var totalInvestment: Double = 0.0
    var roi: Double = 0.0
    
    func setInvestmentDuration(investmentDuration: InvestmentDuration) {
        self.investmentDuration = investmentDuration
    }
    
    private func setMarketPrice(price: Double) {
        self.marketPrice = price
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
}

final class StringFormatter {
    static func getDisplayedDate(date: Date) -> String {
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
    
    static func getCurrencyText(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "Rp"
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedString = numberFormatter.string(from: NSNumber(value: Double(number)/100)) {
            print("Formatted Currency String: \(formattedString)")
            return formattedString
        } else {
            print("Unable to format the number.")
        }
        return "0"
    }
    
    static func getDecimalText(number: Double) -> String {
        let formattedString = String(format: "%.3f", number).replacingOccurrences(of: ".", with: ",")
        return formattedString
    }
}
