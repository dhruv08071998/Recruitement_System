//
//  StudentSideResultTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class StudentSideResultTableViewCell: UITableViewCell {

    @IBOutlet weak var txtTestDate: UILabel!
    @IBOutlet weak var txtResult: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var txtWebsite: UILabel!
    @IBOutlet weak var CompanyImage: UIImageView!
    @IBOutlet weak var txtCompanyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
