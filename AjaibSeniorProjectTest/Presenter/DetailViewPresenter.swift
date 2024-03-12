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
