//
//  SavedCardModel.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 19/04/21.
//

import Foundation
import SwiftyJSON


struct SavedCard {
    
   var payOptId: Int = 0
   var payCardNo: String = ""
   var payOption: String = ""
   var payCardName: String = ""
   var payCardType: String = ""
    
    
    init() {
        
    }
    
    init(json:JSON) {
        payOptId = json["payOptId"].intValue
        payCardNo = json["payCardNo"].stringValue
        payOption = json["payOption"].stringValue
        payCardName = json["payCardName"].stringValue
        payCardType = json["payCardType"].stringValue
    }
}

