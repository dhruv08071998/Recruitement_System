//
//  CompanySidestudentTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class CompanySidestudentTableViewCell: UITableViewCell {

    @IBOutlet weak var StudentImage: UIImageView!
    @IBOutlet weak var txtTestDate: UILabel!
    @IBOutlet weak var txtResult: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var txtFullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
