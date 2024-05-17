//
//  DetailViewController.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 07/03/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private lazy var titleMarketPriceLabel = UILabel().parent(view)
    private lazy var marketPriceTextField = NumericTextField().parent(view)
    private lazy var yearlyProjectionLabel = UILabel().parent(view)
    private lazy var yearlyProjectionTextField = NumericTextField().parent(view)
    private lazy var investmentUnitLabel = UILabel().parent(view)
    private lazy var investmentUnitTextField = NumericTextField().parent(view)
    private lazy var exitReturnLabel = UILabel().parent(view)
    private lazy var selectorView = SelectorView().parent(view)
    private lazy var totalInvestmentTitleLabel = UILabel().parent(view)
    private lazy var totalInvestmentDateLabel = UILabel().parent(view)
    private lazy var totalInvestmentTextField = NumericTextField().parent(view)
    private lazy var roiLabel = UILabel().parent(view)
    
    private let distanceInPixel: CGFloat = CGFloat(8) * UIScreen.main.scale
    
    private let disposeBag = DisposeBag()
    
    private let presenter = DetailViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setValue(isInitial: Bool = false) {
        let marketPrice: String = presenter.getMarketPriceText(numberTextField: marketPriceTextField.numberInTextField, isInitial: isInitial)
        
        let yearlyProjection: String = presenter.getYearlyProjectionText()
        let investmentUnitText: String = presenter.getInvestmentUnitText()
        let totalInvestmentDateText: String = presenter.getTotalInvestmentDateText()
        let dateStartText: String = presenter.getdateStartText()
        let dateEndText: String = presenter.getDateEndText()
        let totalInvestmentValueText: String = presenter.getTotalInvestmentValueText()
        let roiText: String = presenter.getRoiText()
        
        configureValue(
            marketPrice: marketPrice,
            yearlyProjection: yearlyProjection,
            investmentUnitText: investmentUnitText,
            totalInvestmentDateText: totalInvestmentDateText,
            dateStartText: dateStartText,
            dateEndText: dateEndText,
            totalInvestmentValueText: totalInvestmentValueText,
            roiText: roiText
        )
    }
    
    private func configureValue(
        marketPrice: String,
        yearlyProjection: String,
        investmentUnitText: String,
        totalInvestmentDateText: String,
        dateStartText: String,
        dateEndText: String,
        totalInvestmentValueText: String,
        roiText: String
    ) {
        marketPriceTextField.configure(isEnabled: true, text: marketPrice, units: "")
        yearlyProjectionTextField.configure(isEnabled: false, text: yearlyProjection, units: "%")
        investmentUnitTextField.configure(isEnabled: false, text: investmentUnitText, units: "Qty")
        
        totalInvestmentDateLabel.text = totalInvestmentDateText
        setColoredText(originalText: totalInvestmentDateText, dateStart: dateStartText, dateEnd: dateEndText)
        
        totalInvestmentTextField.text = totalInvestmentValueText
        roiLabel.text = roiText
    }
    
    private func setupView() {
        titleMarketPriceLabel.text = "Market Price"
        titleMarketPriceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        yearlyProjectionLabel.text = "Yearly Projection"
        yearlyProjectionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        investmentUnitLabel.text = "Investment Unit"
        investmentUnitLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        exitReturnLabel.text = "Exit Return"
        exitReturnLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        totalInvestmentTitleLabel.text = "Total Investment"
        totalInvestmentTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        roiLabel.textColor = .systemGreen
        
        setupRx()
        setupConstraint()
    }
    
    private func setupRx() {
        presenter.rxEventSimulationViewParamLoaded.asObservable()
            .subscribe(onNext: { [weak self] viewParam in
                self?.setValue(isInitial: true)
            }).disposed(by: disposeBag)

        marketPriceTextField.rxEventUserTyping.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] text in
                self?.setValue()
            }).disposed(by: disposeBag)
        
        selectorView.rxEventUserChangeInvestTime.asObservable()
            .subscribe(onNext: { [weak self] investmentDuration in
                self?.presenter.didUserChangeInvestmentDuration(duration: investmentDuration)
                self?.setValue()
            }).disposed(by: disposeBag)
    }

    private func setupConstraint() {
        titleMarketPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleMarketPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        titleMarketPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleMarketPriceLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        marketPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        marketPriceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        marketPriceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceInPixel).isActive = true
        marketPriceTextField.topAnchor.constraint(equalTo: titleMarketPriceLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        
        yearlyProjectionLabel.translatesAutoresizingMaskIntoConstraints = false
        yearlyProjectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        yearlyProjectionLabel.topAnchor.constraint(equalTo: marketPriceTextField.bottomAnchor, constant: distanceInPixel).isActive = true
        
        let halfWidth = UIScreen.main.bounds.width / 2 - distanceInPixel
        yearlyProjectionTextField.translatesAutoresizingMaskIntoConstraints = false
        yearlyProjectionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        yearlyProjectionTextField.topAnchor.constraint(equalTo: yearlyProjectionLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        yearlyProjectionTextField.widthAnchor.constraint(equalToConstant: halfWidth - 16).isActive = true
        
        investmentUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        investmentUnitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceInPixel).isActive = true
        investmentUnitLabel.topAnchor.constraint(equalTo: marketPriceTextField.bottomAnchor, constant: distanceInPixel).isActive = true
        
        investmentUnitTextField.translatesAutoresizingMaskIntoConstraints = false
        investmentUnitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceInPixel).isActive = true
        investmentUnitTextField.topAnchor.constraint(equalTo: investmentUnitLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        investmentUnitTextField.widthAnchor.constraint(equalToConstant: halfWidth).isActive = true
        
        exitReturnLabel.translatesAutoresizingMaskIntoConstraints = false
        exitReturnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        exitReturnLabel.topAnchor.constraint(equalTo: yearlyProjectionTextField.bottomAnchor, constant: distanceInPixel).isActive = true
        
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        selectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceInPixel).isActive = true
        selectorView.topAnchor.constraint(equalTo: exitReturnLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        selectorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        totalInvestmentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        totalInvestmentTitleLabel.topAnchor.constraint(equalTo: selectorView.bottomAnchor, constant: distanceInPixel).isActive = true
        
        totalInvestmentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        totalInvestmentDateLabel.topAnchor.constraint(equalTo: totalInvestmentTitleLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        
        totalInvestmentTextField.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        totalInvestmentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -distanceInPixel).isActive = true
        totalInvestmentTextField.topAnchor.constraint(equalTo: totalInvestmentDateLabel.bottomAnchor, constant: distanceInPixel/2).isActive = true
        totalInvestmentTextField.configure(isEnabled: false, text: "", units: "")
        
        roiLabel.translatesAutoresizingMaskIntoConstraints = false
        roiLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: distanceInPixel).isActive = true
        roiLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: distanceInPixel).isActive = true
        roiLabel.topAnchor.constraint(equalTo: totalInvestmentTextField.bottomAnchor, constant: distanceInPixel/2).isActive = true
    }
    
    private func setColoredText(
        originalText: String,
        dateStart: String,
        dateEnd: String
    ) {
        let attributedString = NSMutableAttributedString(string: originalText)

        let dateStartRange = (originalText as NSString).range(of: dateStart)
        let dateEndRange = (originalText as NSString).range(of: dateEnd)

        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: dateStartRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: dateEndRange)
        
        totalInvestmentDateLabel.attributedText = attributedString
    }
}
