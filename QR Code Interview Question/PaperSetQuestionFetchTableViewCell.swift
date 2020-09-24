//
//  PaperSetQuestionFetchTableViewCell.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 03/02/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit

class PaperSetQuestionFetchTableViewCell: UITableViewCell {

    @IBAction func BtnPress(_ sender: Any) {
        if( Btnoutlet.title(for: .normal) == "Add" )
        {
           
            arr.append(txtQstId.text!)
            count = arr.count
            Btnoutlet.setTitle("Undo", for: .normal)
            print(arr)
        }
        else
        {
            
            while arr.contains(txtQstId.text!) {
                if let itemToRemoveIndex = arr.index(of: txtQstId.text!) {
                    arr.remove(at: itemToRemoveIndex)
                }
            }
            count = arr.count
            Btnoutlet.setTitle("Add", for: .normal)
            print(arr)
        }
        
        
    }
    @IBOutlet weak var txtOtherDetails: UILabel!
    @IBOutlet weak var Btnoutlet: roundedBtn!
    @IBOutlet weak var txtQuestion: UILabel!
    @IBOutlet weak var txtQstId: UILabel!
    @IBOutlet weak var txtDifficultylevel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
