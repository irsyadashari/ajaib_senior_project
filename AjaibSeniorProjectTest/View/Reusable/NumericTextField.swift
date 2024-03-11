//
//  NumericTextField.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 08/03/24.
//

import UIKit
import RxSwift
import RxCocoa

final class NumericTextField: UITextField {
    private lazy var customText = UILabel()
    
    let rxEventUserTyping = PublishSubject<String>()

    private let disposeBag = DisposeBag()

    var numberInTextField: Double {
        guard let textFieldText = self.text, !textFieldText.isEmpty else { return 0.0 }
        var sanitizedString = textFieldText
            .replacingOccurrences(of: ".", with: ",")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "Rp", with: "")
        sanitizedString = sanitizedString.trimmingCharacters(in: .whitespaces)
        return Double(sanitizedString) ?? 0
    }
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(isEnabled: Bool, text: String, units: String) {
        self.isEnabled = isEnabled
        if !isEnabled {
            self.backgroundColor = .systemGray6
        }
        
        self.text = text
        self.customText.text = units
    }
    
    private func setupView() {
        keyboardType = .numberPad
        addDoneButtonOnKeyboard()
        
        layer.borderColor = UIColor.backgroundContrastColor.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        
        // Left padding
        let textPadding: CGFloat = 8.0  // Adjust the padding as needed
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: textPadding, height: frame.size.height))
        leftViewMode = .always
        // Right padding
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: textPadding, height: frame.size.height))
        rightViewMode = .always
        
        // Requirement 2: Custom text setup
        customText.textAlignment = .center
        customText.text = "%"
        customText.textColor = UIColor.backgroundContrastColor

        addSubview(customText)
        
        // Restrict input to numbers only
        addTarget(self, action: #selector(restrictInputToNumbers), for: .editingChanged)
        
        setupRx()
        setupConstraint()
    }
    
    private func setupRx() {
        rx.controlEvent(.editingChanged)
            .debounce(.milliseconds(10), scheduler: MainScheduler.instance)
            .map { [weak self] _ in self?.text ?? "" }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                // Only trigger when the user is actively typing
                guard let isEditing = self?.isEditing, isEditing else {
                    return
                }

                self?.rxEventUserTyping.onNext(text)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupConstraint() {
        customText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            customText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            customText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func restrictInputToNumbers() {
        let allowedCharacters = CharacterSet.decimalDigits
        let filteredText = text?.filter { allowedCharacters.contains(UnicodeScalar(String($0))!) } ?? ""
        text = filteredText
    }
}

