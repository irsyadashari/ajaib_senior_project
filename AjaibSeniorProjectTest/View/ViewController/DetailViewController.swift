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
    
    var totalInvestment: Int {
        let marketPrice = marketPriceTextField.numberInTextField
        let yearlyProjection = yearlyProjectionTextField.numberInTextField
        let investmentUnit = investmentUnitTextField.numberInTextField
        return marketPrice * yearlyProjection * investmentUnit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadValues()
    }
    
    private func loadValues() {
        
        //get this value from interactor in the future
        configure(
            yearlyProjectionText: "8,3",
            investmentUnitText: "0,53",
            totalInvestmentDateText: "From 5 Nov 2024 to 5 Nov 2029",
            dateStartText: "5 Nov 2024",
            dateEndText: "5 Nov 2029",
            roi: "64.050,68"
        )
    }
    
    private func configure(
        yearlyProjectionText: String,
        investmentUnitText: String,
        totalInvestmentDateText: String,
        dateStartText: String,
        dateEndText: String,
        roi: String
    ) {
        yearlyProjectionTextField.configure(isEnabled: false, text: yearlyProjectionText, units: "%")
        investmentUnitTextField.configure(isEnabled: false, text: investmentUnitText, units: "Qty")
        
        totalInvestmentDateLabel.text = totalInvestmentDateText
        setColoredText(originalText: totalInvestmentDateText, dateStart: dateStartText, dateEnd: dateEndText)
        roiLabel.text = "ROI : Rp.\(roi)%"
    }
    
    private func setupView() {
        titleMarketPriceLabel.text = "Market Price"
        titleMarketPriceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        marketPriceTextField.configure(isEnabled: true, text: "", units: "")
        
        yearlyProjectionLabel.text = "Yearly Projection"
        yearlyProjectionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        investmentUnitLabel.text = "Investment Unit"
        investmentUnitLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        exitReturnLabel.text = "Exit Return"
        exitReturnLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        totalInvestmentTitleLabel.text = "Total Investment"
        totalInvestmentTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        roiLabel.textColor = .green
        
        setupRx()
        setupConstraint()
    }
    
    private func setupRx() {
        marketPriceTextField.rxEventUserTyping.asObservable()
            .subscribe(onNext: { [weak self] text in
                self?.updateTotalInvestment()
            }).disposed(by: disposeBag)
    }
    
    private func updateTotalInvestment() {
        
        totalInvestmentTextField.text = String(totalInvestment)
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

        attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: dateStartRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: dateEndRange)
        
        totalInvestmentDateLabel.attributedText = attributedString
    }
}

