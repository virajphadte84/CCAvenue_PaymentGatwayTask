//
//  PayOptionModel.swift
//  ccAvenueTask
//
//  Created by AT-mac04 on 19/04/21.
//

import Foundation
import SwiftyJSON

struct PayOption {
    var payOpt : String = ""
    var payOptDesc : String = ""
    
    init() {
        
    }
    
    init(json:JSON) {
        payOpt = json["payOpt"].stringValue
        payOptDesc = json["payOptDesc"].stringValue
    }
}
