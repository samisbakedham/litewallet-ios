//
//  PreTransferViewModel.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/6/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import Foundation
import SwiftUI

class PreTransferViewModel: ObservableObject {
    
    /// Sets tthe wallet type, the image and the label
    enum WalletType: String {
        
        case litecoinCard
        case litewallet
        
        var description: String {
            switch self {
                case .litecoinCard:
                    return "litecoin-card-front"
                case .litewallet:
                    return "coinBlueWhite"
            }
        }
 
        var balanceLabel: String {
            switch self {
                case .litecoinCard:
                    return "Card Balance:"
                case .litewallet:
                    return "Litewallet Balance:"
            }
        }
    }
        
    //MARK: - Public Parameters
    
    var walletType: WalletType
    
    var balance: Double
    
    var isTapped: Bool = false
    
    init(walletType: WalletType, balance: Double) {
        
        self.walletType = walletType
        
        self.balance = balance
    }
}




