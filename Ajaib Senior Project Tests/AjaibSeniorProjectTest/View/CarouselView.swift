//
//  CarouselView.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

final class CarouselView: UIView {
    private var collectionView: UICollectionView!

    private var presenter: CarouselViewPresenter?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func set(presenter: CarouselViewPresenter) {
        self.presenter = presenter
        self.collectionView.reloadData()
    }
    
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CarouselViewCell.self, forCellWithReuseIdentifier: CarouselViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        setupConstraint()
    }
    
    private func setupConstraint() {
        collectionView.pinCenter(to: self)
    }
}

extension CarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.colors.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselViewCell.reuseIdentifier,
            for: indexPath
        ) as! CarouselViewCell
        let hexText: String = presenter?.getColor(at: indexPath.row) ?? "No Color Found"
        cell.configure(hexText: hexText)
        return cell
    }
    
}

extension CarouselView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8 // Adjust the minimum interitem spacing as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var screenWidth = UIScreen.main.bounds.width - 32
        let reductionWidth = UIScreen.main.bounds.width * 0.3
        if (presenter?.getColors().count ?? 0) > 1 {
            screenWidth -= reductionWidth
        }
        return CGSize(width: screenWidth, height: 100)
    }
}
