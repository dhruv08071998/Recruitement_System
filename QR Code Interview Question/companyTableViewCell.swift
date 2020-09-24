//
//  companyTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 27/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class companyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var txtCompanyName: UILabel!
    @IBOutlet weak var imgCompanylogo: UIImageView!
    @IBOutlet weak var txtappliDate: UILabel!
    @IBOutlet weak var txttestDate: UILabel!
    @IBOutlet weak var txtlocation: UILabel!
    @IBOutlet weak var txtwebsite: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
