//
//  DetailViewControllerTests.swift
//  AjaibSeniorProjectTestTests
//
//  Created by Muh Irsyad Ashari on 12/03/24.
//

import XCTest
import RxSwift
import RxTest
@testable import AjaibSeniorProjectTest

//final class DetailViewControllerTests: XCTestCase {
//    var viewController: DetailViewController!
//    var scheduler: TestScheduler!
//    var disposeBag: DisposeBag!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        viewController = DetailViewController()
//        scheduler = TestScheduler(initialClock: 0)
//        disposeBag = DisposeBag()
//    }
//
//    override func tearDownWithError() throws {
//        viewController = nil
//        scheduler = nil
//        disposeBag = nil
//        try super.tearDownWithError()
//    }
//
//    func testViewConfiguredAfterLoading() {
//        // Given
//        let observer = scheduler.createObserver(String.self)
//
//        // When
//        viewController.rx.viewDidAppear
//            .subscribe(onNext: { [weak self] _ in
//                // ViewDidAppear triggers configuration
//                self?.viewController.view.setNeedsLayout()
//                self?.viewController.view.layoutIfNeeded()
//            })
//            .disposed(by: disposeBag)
//
//        // Then
//        let expectedEvents: [Recorded<Event<String>>] = [
//            .next(0, "Market Price")
//        ]
//
//        XCTAssertEqual(observer.events, expectedEvents)
//    }
//
//    func testMarketPriceTextFieldConfiguredAfterTyping() {
//        // Given
//        let observer = scheduler.createObserver(String.self)
//
//        // When
//        viewController.rx.viewDidAppear
//            .flatMap { _ in
//                return self.viewController.marketPriceTextField.rxEventUserTyping
//            }
//            .subscribe(observer)
//            .disposed(by: disposeBag)
//
//        scheduler.createColdObservable([.next(10, "123.45"), .next(20, "678.90")])
//            .bind(to: viewController.marketPriceTextField.rx.text!)
//            .disposed(by: disposeBag)
//
//        scheduler.start()
//
//        // Then
//        let expectedEvents: [Recorded<Event<String>>] = [
//            .next(10, "123.45"),
//            .next(20, "678.90")
//        ]
//
//        XCTAssertEqual(observer.events, expectedEvents)
//    }
//}

