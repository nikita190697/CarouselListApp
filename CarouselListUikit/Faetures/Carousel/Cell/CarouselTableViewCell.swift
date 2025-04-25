//
//  CarouselTableViewCell.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 25/04/25.
//

import UIKit
protocol CarouselSelectionDelegate: AnyObject {
    func carouselDidUpdate(_ index: Int)
}
final class CarouselTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variables
    weak var delegate: CarouselSelectionDelegate?
    var carouselItems: [CarouselItem] = [] {
        didSet {
            pageControl.numberOfPages = carouselItems.count
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension CarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CarouselCollectionViewCell",
            for: indexPath) as! CarouselCollectionViewCell
        
        
        let imgStr = carouselItems[indexPath.item].title
        cell.imgView.image = UIImage(named: imgStr)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath.item)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CarouselTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Scroll view delegate
extension CarouselTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == collectionView else { return }
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = pageIndex
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == collectionView else { return }
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        delegate?.carouselDidUpdate(pageIndex)
    }
}
