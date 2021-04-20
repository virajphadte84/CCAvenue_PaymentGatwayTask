//
//  SavedCardsTableViewCell.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 20/04/21.
//

import UIKit

class SavedCardsTableViewCell: UITableViewCell {
    @IBOutlet weak var payAmountBtn: UIButton!
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var cvvTextField: textFieldStyle!
    @IBOutlet weak var cardTypeImage: UIImageView!
    @IBOutlet weak var showPaymentBtn: buttonViewStyle!
    var savedDelegate : savedCardAlert?
    @IBOutlet weak var payAmountBtnHieghtConstraint: NSLayoutConstraint!
    var isCardSelected :Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        payAmountBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func payAmountAction(_ sender: Any) {
        if (cvvTextField.text != "" && cvvTextField.text?.count == 3){
            savedDelegate?.showPaymentAlert(title: "Confirm Payment", message: "Do you want to pay?")
        } else {
          
            var message = ""
            
            if (cvvTextField.text ==  "") {
                message = "Please enter CVV number."
            } else {
                message = "Please enter correct CVV number."
            }
            savedDelegate?.showPaymentAlert(title: "Error", message: message)
        }
    }
    @IBAction func showHidePayment(_ sender: Any) {
        if (isCardSelected == false) {
            payAmountBtn.isHidden = false
            isCardSelected = true
            payAmountBtnHieghtConstraint.constant = 30
            showPaymentBtn.backgroundColor = UIColor.orange
        } else {
            payAmountBtn.isHidden = true
            isCardSelected = false
            payAmountBtnHieghtConstraint.constant = 0
            showPaymentBtn.backgroundColor = UIColor.white
        }
    }
    
  
}

protocol savedCardAlert {
    func showPaymentAlert(title : String , message : String )
}
