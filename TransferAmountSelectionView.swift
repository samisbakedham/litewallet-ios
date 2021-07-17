//
//  TransferAmountSelectionView.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import SwiftUI
  
struct TransferAmountSelectionView: View {
    
    
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: TransferAmountSelectionViewModel
//    
//    
//    @State
//    var usernameEmail: String = ""
//    
//    @State
//    var password: String = ""
//    
//    @State
//    var confirmPassword: String = ""
    
    
    init(viewModel: TransferAmountSelectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
 
struct TransferAmountSelectionView_Previews: PreviewProvider {
    
    static let viewModel = TransferAmountSelectionViewModel()
    static var previews: some View {
        TransferAmountSelectionView(viewModel: viewModel)
    }
}
