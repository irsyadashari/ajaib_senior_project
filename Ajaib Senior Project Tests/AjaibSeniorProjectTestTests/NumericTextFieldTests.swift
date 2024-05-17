//
//  NumericTextFieldTests.swift
//  AjaibSeniorProjectTestTests
//
//  Created by Muh Irsyad Ashari on 12/03/24.
//

import XCTest
import RxSwift
import RxTest
@testable import AjaibSeniorProjectTest

final class NumericTextFieldTests: XCTestCase {
    var numericTextField: NumericTextField!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        numericTextField = NumericTextField()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        numericTextField = nil
        scheduler = nil
        disposeBag = nil
        try super.tearDownWithError()
    }

    func testConfigure_shouldParseDisplayedTextCorrectly() {
        numericTextField.configure(isEnabled: true, text: "Rp 123.45", units: "QTY")
        
        XCTAssertEqual(numericTextField.text, "Rp 123.45")
    }

    func testNumberInTextFieldCalculation() {
        // Given
        numericTextField.text = "Rp 123.45"

        // When
        let result = numericTextField.numberInTextField

        // Then
        XCTAssertEqual(result, 12345.0)
    }
}
