//
//  TweetTableViewCell.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/31/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
