//
//  MockAPIService.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation
import RxSwift

final class MockAPIService {
    static func getSimulationDomainModel() -> Observable<SimulationDomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-Simulation-DetailPage", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-Simulation-DetailPage is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(SimulationResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: SimulationResponse) -> SimulationDomainModel? in
                print("check response: \(it)")
                return it.toModel()
            }.do(onError: { error in
                print(error)
            })
                } catch (let error) {
                    return Observable.error(error)
                }
    }
}
