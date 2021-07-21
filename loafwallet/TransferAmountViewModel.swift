//
//  TransferAmountViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import Foundation

class TransferAmountViewModel: ObservableObject {
      
    @Published
    var transferAmountString: String = ""
    
    @Published
    var newBalanceString: String = ""
    
    var litewalletBalance: Double =  0.0
    
    var litecoinCardBalance: Double = 0.0
    
    var transferAmount: Double {
        return Double(transferAmountString) ?? 0.0
    }
    
    init() {
        
    }
     
}

