//
//  PaperSetFetchTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class PaperSetFetchTableViewCell: UITableViewCell {

    @IBOutlet weak var txtSetName: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var QrImage: UIImageView!
    @IBOutlet weak var txtSetid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
