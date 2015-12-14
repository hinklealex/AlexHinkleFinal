//
//  TableViewCell.swift
//  BibleBooks
//
//  Created by Alex Hinkle on 12/14/15.
//  Copyright © 2015 cuw. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
