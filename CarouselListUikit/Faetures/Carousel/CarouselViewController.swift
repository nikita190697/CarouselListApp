//
//  ViewController.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 25/04/25.
//

import UIKit

final class CarouselViewController: UIViewController {
    // MARK: - Varibales
    private let viewModel = CarouselViewModel()
    // MARK: - outlets
    @IBOutlet weak var tblView: UITableView!
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
    }
    // MARK: - Action
    @IBAction func actionShowStats(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let statsVC = storyboard.instantiateViewController(withIdentifier: "StatsBottomSheetViewController") as? StatsBottomSheetViewController {
            statsVC.stats = viewModel.stats
            statsVC.count = viewModel.currentItem?.items.count ?? 0
            statsVC.titleText = viewModel.currentItem?.title ?? ""
            statsVC.modalPresentationStyle = .popover
            self.present(statsVC, animated: true)
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDataSource
extension CarouselViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.filteredItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarouselTableViewCell", for: indexPath) as! CarouselTableViewCell
            cell.carouselItems = viewModel.carouselItems
            cell.delegate = self
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
            cell.item = viewModel.filteredItems[indexPath.row]
            return cell
        }
    }
    // MARK: - Search Bar in Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView()
            headerView.backgroundColor = .systemBackground
            
            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.backgroundImage = UIImage()
            searchBar.frame = CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 44)
            
            headerView.addSubview(searchBar)
            return headerView
        } else {
            return nil
        }
    }
    // MARK: - Adjusting Section Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 56
        }
        return 0
    }
}
// MARK: - CarouselSelectionDelegate
extension CarouselViewController: CarouselSelectionDelegate {
    func carouselDidUpdate(_ index: Int) {
        viewModel.selectedIndex = index
        viewModel.currentItem = viewModel.carouselItems[index]
        viewModel.updateFilteredItems()
        let indexSet = IndexSet(integer: 1)
        tblView.reloadSections(indexSet, with: .automatic)
    }
}
// MARK: - UISearchBarDelegate
extension CarouselViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.updateFilteredItems()
        tblView.reloadData()
    }
}
