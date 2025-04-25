//
//  ListTableViewCell.swift
//  CarouselListUikit
//
//  Created by Nikita Patidar on 25/04/25.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    // MARK: - Variables
    var item: ListItem? {
        didSet {
            setData()
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // MARK: - Utility
    private func setData() {
        guard let item else { return }
        lblTitle.text = item.title
        lblDesc.text = item.description
        if let strImage = item.imageName {
            imgView.image = UIImage(named: strImage)
        }
    }
}
