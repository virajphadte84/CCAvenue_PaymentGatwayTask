//
//  DirectDebitTableViewCell.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 20/04/21.
//

import UIKit

class DirectDebitTableViewCell: UITableViewCell {

   
    @IBOutlet weak var cardNumberTextField: textFieldStyle!
    @IBOutlet weak var cvvTextField: textFieldStyle!
    @IBOutlet weak var expiryAgeTextField: textFieldStyle!
    var debitDelegate : debitCardAlert?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func payAmountAction(_ sender: Any) {
        if (cvvTextField.text != "" && cvvTextField.text?.count == 3 &&  cardNumberTextField.text != "" && expiryAgeTextField.text != "" ){
            debitDelegate?.showPaymentAlert(title: "Confirm Payment", message: "Do you want to pay?")
        } else {
          
            var message = ""
            
            if (cardNumberTextField.text == ""){
                
                message = "Please enter Card member name."
                
            } else if (expiryAgeTextField.text == ""){
                
                message = "Please enter card expiry date."
                
            } else { if (cvvTextField.text ==  "") {
                
                message = "Please enter CVV number."
                
            } else  {
                message = "Please enter correct CVV number."
            }
            
            }
            //  debitDelegate?.showSavedCardAlert(title: "Error", message: message)
            debitDelegate?.showPaymentAlert(title: "Error", message: message)
        }
    }
    
 
}

protocol debitCardAlert {
    func showPaymentAlert(title : String , message : String )
}
