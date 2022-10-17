//
//  NewsfeedCell.swift
//  VkNewsFeed
//
//  Created by urichese on 17.10.2022.
//

import Foundation
import UIKit

class NewsfeedCell:UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    static let reuseId = "NewsfeedCell"
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
