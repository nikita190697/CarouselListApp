//
//  StatsBottomSheetViewController.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 25/04/25.
//

import UIKit

final class StatsBottomSheetViewController: UIViewController {
    // MARK: - variables
    var stats: [String: Int] = [:]
    var count: Int = 0
    var titleText: String = ""
    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    // MARK: - view Life Cylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    // MARK: - Utility
    func setData() {
        lblTitle.text = "Stats for \(titleText)"
        lblCount.text = "Items: \(count)"
        let sortedStats = stats.sorted { $0.value > $1.value }
        let formattedText = sortedStats.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
        lblDetail.numberOfLines = 0
        lblDetail.text = formattedText
    }
}
