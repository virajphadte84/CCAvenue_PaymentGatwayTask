//
//  UPIPaymentsTableViewCell.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 20/04/21.
//

import UIKit

class UPIPaymentsTableViewCell: UITableViewCell {

    @IBOutlet weak var upiPaymentLabel: UILabel!
    var upiPaymentDelegate : upiPaymentAlert?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func payAmountAction(_ sender: Any) {

        upiPaymentDelegate?.showPaymentAlert(title: "Confirm Payment", message: "Do you want to pay?")
     
    }
    

}

protocol upiPaymentAlert {
    func showPaymentAlert(title : String , message : String )
}
