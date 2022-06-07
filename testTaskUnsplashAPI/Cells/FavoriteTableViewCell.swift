//
//  FavoriteTableViewCell.swift
//  testTaskUnsplashAPI
//
//  Created by gleba on 30.04.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
