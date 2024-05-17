//
//  SelectorView.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 07/03/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SelectorView: UIView {
    private var collectionView: UICollectionView!
    private var selectedIndex: Int = 0
    
    let rxEventUserChangeInvestTime = PublishSubject<InvestmentDuration>()
    
    private let disposeBag = DisposeBag()
    
    // Your data for the carousel
    private let options: [InvestmentDuration] = [.sixMonth, .oneYear, .threeYear, .fiveYear]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectorCell.self, forCellWithReuseIdentifier: SelectorCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear

        addSubview(collectionView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

extension SelectorView: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        self.rxEventUserChangeInvestTime.onNext(options[indexPath.row])
    }
}

extension SelectorView: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width / 4 - 8, height: bounds.height - 8)
    }
}

extension SelectorView: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectorCell.identifier, for: indexPath) as! SelectorCell
        let option: InvestmentDuration = options[indexPath.item]
        var cellText: String = ""
        switch option {
        case .sixMonth:
            cellText = "6M"
        case .oneYear:
            cellText = "1Y"
        case .threeYear:
            cellText = "3Y"
        case .fiveYear:
            cellText = "5Y"
        }
        cell.titleLabel.text = cellText
        
        let isSelectedCell  = (indexPath.item == selectedIndex)
        cell.isSelectedCell = isSelectedCell
        let cellColor = isSelectedCell ? UIColor.red.cgColor : UIColor.backgroundContrastColor.cgColor
        cell.layer.borderColor = cellColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        return cell
    }
}

final class SelectorCell: UICollectionViewCell {
    static let identifier = "CarouselCellIdentifier"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.backgroundContrastColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var isSelectedCell: Bool = false {
        didSet {
            titleLabel.textColor = isSelectedCell ? UIColor.red : UIColor.backgroundContrastColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override var isSelected: Bool {
        didSet {
            isSelectedCell = isSelected
        }
    }
}
