//
//  ViewController.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 19/04/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var payOptionArray = [PayOption]()
    var saveCardArray = [SavedCard]()
    var isDebitCredirPresent = false
    var isSamsungPayPresent = false
    var isChinaUnionPresent = false
    @IBOutlet weak var paymentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        loadCardData()
        
 
    }

    func loadCardData(){
        
        let url = "http://ec2-13-233-32-142.ap-south-1.compute.amazonaws.com/api/merchant_pay_option.php"
         let paymentRequest = AF.request(url)
               
          paymentRequest.responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let datajson = JSON(value)
               
               if (datajson["payOptions"] !=  nil ){
                    for  payOptions in  datajson["payOptions"].arrayValue {
                        self.payOptionArray.append(PayOption(json: payOptions))
                    }
                }
                if (datajson["savedCard"] !=  nil ){
                    for saveCard in  datajson["savedCard"].arrayValue {
                        self.saveCardArray.append(SavedCard(json: saveCard))
                    }
                }
                self.checkPaymentOptionStatus()
                DispatchQueue.main.async {
                    self.paymentTableView.reloadData()
                }
             
       
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
//MARK :- Table view delegate methods
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var sectionCount = 0
        switch section {
        case 0: sectionCount = saveCardArray.count
            
        case 1: sectionCount = isDebitCredirPresent == true ? 1 : 0
            
        case 2: sectionCount = isSamsungPayPresent == true ? 1 : 0
            
        case 3: sectionCount = isChinaUnionPresent == true ? 1 : 0
            
        default:
            print("in default")
        }
        
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        switch  indexPath.section {
        case 0:
            
           return SavedCardCellConfiguration(for: indexPath)
        case 1:
            return  DerictDebitCellConfiguration(for: indexPath)
        case 2:
            return  UPIPaymentCardCellConfiguration(for: indexPath)
        case 3:
           return  UPIPaymentCardCellConfiguration(for: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerName = ""
        switch section {
        case 0: headerName = "Saved Cards"
            
        case 1: headerName = "Debit Credit Card"
            
        case 2: headerName = "Samsung Pay"
            
        case 3: headerName = "China Union Pay"
            
        default:
            print("in default")
        }
        let button = UIButton()
        button.setTitle(headerName, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
      
        return button
    }
    

}

//MARK :- Table view cell configuration
extension ViewController {
    
    
    func SavedCardCellConfiguration(for indexpath : IndexPath) -> UITableViewCell{
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "savedCardCell", for: indexpath) as! SavedCardsTableViewCell
        
        cell.savedDelegate = self
        var savedCard = saveCardArray[indexpath.row]
        cell.cardNumberLabel.text = "XXXX XXXX XXXX \(savedCard.payCardNo)"
        if(savedCard.payCardName == "MasterCard") {
            cell.cardTypeImage.image = UIImage(named:"masterCardImage.jpeg")
        } else if(savedCard.payCardName == "VISA") {
            cell.cardTypeImage.image = UIImage(named:"VISAIMAGE.jpeg")
        } else {
            cell.cardTypeImage.image = UIImage(named:"defaultCardImage.jpeg" )
        }
        return cell
    }
    
    func DerictDebitCellConfiguration(for indexpath : IndexPath) -> UITableViewCell{
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "directDebitCell", for : indexpath) as! DirectDebitTableViewCell
        cell.debitDelegate = self
        return cell
    }
    
    func UPIPaymentCardCellConfiguration(for indexpath : IndexPath)-> UITableViewCell{
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "upiPaymentCell", for : indexpath) as! UPIPaymentsTableViewCell
        cell.upiPaymentDelegate = self
      
        if (payOptionArray.count != 0 ) {
         
            if (payOptionArray.count == 2) {
                
                
                if (isDebitCredirPresent == false){
                    if(indexpath.section == 2) {
                        cell.upiPaymentLabel.text =  payOptionArray[0].payOptDesc
                    } else if (indexpath.section == 3){
                        cell.upiPaymentLabel.text =  payOptionArray[1].payOptDesc
                    }
                } else {
                    if(isSamsungPayPresent == true){
                        if(indexpath.section == 2) {
                            cell.upiPaymentLabel.text =  payOptionArray[1].payOptDesc
                        }
                    }else if(isChinaUnionPresent == true){
                        if(indexpath.section == 3) {
                            cell.upiPaymentLabel.text =  payOptionArray[1].payOptDesc
                        }
                    }
                }
                    
            }else if (payOptionArray.count == 3){
                

                if(indexpath.section == 2) {
                    cell.upiPaymentLabel.text =  payOptionArray[1].payOptDesc
                } else if(indexpath.section == 3) {
                    cell.upiPaymentLabel.text =  payOptionArray[2].payOptDesc
                }
            }
            
     
        }
        return cell
    }
}


extension ViewController : savedCardAlert , debitCardAlert , upiPaymentAlert{
    func showPaymentAlert(title: String, message: String) {
        showalertMessage(titleAlert: title, messageAlert: message)

    }
}

//MARK :- show alert
extension ViewController {
    
    
    func showalertMessage(titleAlert alertTitle : String, messageAlert alertMsg : String){
           let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle:.alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           self.present(alertController, animated: true, completion: nil)
           
       }
}

//MARK :- check payment card count
extension ViewController {
    
    func checkPaymentOptionStatus(){
        for payOption in payOptionArray {
            
            if payOption.payOpt == "OPTCARD" {
                isDebitCredirPresent = true
            }
            
            if payOption.payOpt == "OPTSPAY" {
                isSamsungPayPresent = true
            }
            if payOption.payOpt == "OPTCUPAY" {
                isChinaUnionPresent = true
            }
        }
    }
}
