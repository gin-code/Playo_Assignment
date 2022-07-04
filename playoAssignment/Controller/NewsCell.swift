//
//  NewsCell.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextview: UITextView!

    override func awakeFromNib() {
        newsView.clipsToBounds = true
        newsView.layer.cornerRadius = 8.0
        newsView.layer.borderColor = UIColor.systemGray.cgColor
        newsView.layer.borderWidth = 1.0
    }
}
