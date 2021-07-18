//
//  TransferAmountSelectionViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import Foundation

class TransferAmountSelectionViewModel: ObservableObject {
      
    @Published
    var transferAmountString: String = ""
    
    var litewalletBalance: Double =  0.0
    
    var litecoinCardBalance: Double = 0.0
    
    var transferAmount: Double {
        return Double(transferAmountString) ?? 0.0
    }
    
    init() {
        
    }
    
    /// Calculating the new wallet balance: Since this is such a trivial calculation it is made more bulletproof so the amount transferred is not violating the business logic.
    /// - Parameters:
    ///   - walletType: Which wallet that will doing the transfer
    ///   - transferAmount: User chooses which amount
    /// - Returns: the new wallet balance
    
    func newBalance(walletType: WalletType, transferAmount: Double) -> Double {
        
        var newBalance: Double = 0.0
        
        if walletType == .litecoinCard {
             
            let amount = transferAmount > litecoinCardBalance ? litecoinCardBalance : transferAmount
            
            newBalance = litecoinCardBalance - amount
            
        } else if walletType == .litewallet {
             
            let amount = transferAmount > litewalletBalance ? litewalletBalance : transferAmount
            
            newBalance = litewalletBalance - amount 
        }
        
        return newBalance
    }
    
    func endingBalance(walletType: WalletType, transferAmount: Double) -> Double {
        return walletType == .litecoinCard ?
            (litewalletBalance + transferAmount) :
            (litecoinCardBalance + transferAmount)
    }
    
}

