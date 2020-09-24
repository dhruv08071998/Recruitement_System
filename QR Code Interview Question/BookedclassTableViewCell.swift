//
//  BookedclassTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class BookedclassTableViewCell: UITableViewCell {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var txttestdate: UILabel!
    @IBOutlet weak var txtlocation: UILabel!
    @IBOutlet weak var txtwebsite: UILabel!
    @IBOutlet weak var companyimage: UIImageView!
    @IBOutlet weak var txtcompanyName: UILabel!
    @IBOutlet weak var txttechnologyname: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
