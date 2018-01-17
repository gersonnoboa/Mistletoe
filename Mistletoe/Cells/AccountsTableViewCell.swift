//
//  AccountsTableViewCell.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 17/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profilePicture.layer.cornerRadius = 10
        self.profilePicture?.clipsToBounds = true
    }
    
}
