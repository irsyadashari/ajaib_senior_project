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
                return it.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
    
    static func getUserVerified() -> Observable<UserDomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-User-Verified", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-User-Verified is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(UserResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: UserResponse) -> UserDomainModel? in
                return it.user.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
    
    static func getUserNotVerified() -> Observable<UserDomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-User", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-User is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(UserResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: UserResponse) -> UserDomainModel? in
                return it.user.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
    
    static func getPayments() -> Observable<PaymentDomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-Payments", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-Payments is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(PaymentResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: PaymentResponse) -> PaymentDomainModel? in
                return it.payments.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
    
    static func getBanners() -> Observable<CTADomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-CTA-Multiple", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-CTA-Multiple is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(CTAResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: CTAResponse) -> CTADomainModel? in
                return it.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
    
    static func getSingleBanners() -> Observable<CTADomainModel> {
        guard let jsonPath = Bundle.main.path(forResource: "Mock-CTA-Single", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe) else {
            fatalError("Mock-CTA-Single is not found")
        }
        do {
            let decoded = try JSONDecoder().decode(CTAResponse.self, from: jsonData)
            return Observable.just(decoded).compactMap { (it: CTAResponse) -> CTADomainModel? in
                return it.toModel()
            }.do(onError: { error in
                print(error)
            })
            } catch (let error) {
                return Observable.error(error)
            }
    }
}
