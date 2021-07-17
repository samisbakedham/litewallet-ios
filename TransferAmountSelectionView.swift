//
//  TransferAmountSelectionView.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct TransferAmountSelectionView: View {
    
    let mainPadding: CGFloat = 40.0
 
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: TransferAmountSelectionViewModel
    
    @Binding
    var shouldShow: Bool
    
    @State
    var transferAmount: Double = 0.0
    
    @State
    var transferAmountString: String = ""
    
    //MARK: - Private Variables
    private var litewalletBalance: Double
    
    private var litecoinCardBalance: Double
    
    init(viewModel: TransferAmountSelectionViewModel,
         litewalletBalance: Double,
         litecoinCardBalance: Double,
         shouldShow: Binding<Bool>) {
        
        self.litewalletBalance = litewalletBalance
        
        self.litecoinCardBalance = litecoinCardBalance
        
        _shouldShow = shouldShow
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Current Balance: ")
                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                    .foregroundColor(Color.liteWalletBlue)
                Spacer()
                Text("250.00 Ł")
                    .font(Font(UIFont.barlowLight(size: 20.0)))
                    .foregroundColor(Color.liteWalletBlue)
            }
            
            HStack {
                Text("Transfer amount: ")
                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                    .foregroundColor(Color.liteWalletBlue)
                Spacer()
                TextField("Enter amount", text: $transferAmountString) { (changedValue) in
                    print("\(changedValue)")
                } onCommit: {
                    print("committed")
                    
                }
                .multilineTextAlignment(.trailing)
                .font(Font(UIFont.barlowLight(size: 20.0)))
                .frame(width: 150)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.5,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.litecoinGray)

            HStack {
                Text("Ending Balance: ")
                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                    .foregroundColor(Color.liteWalletBlue)
                Spacer()
                Text("200.0 Ł")
                    .font(Font(UIFont.barlowLight(size: 20.0)))
                    .foregroundColor(Color.liteWalletBlue)
            }
            .padding(.bottom, 50.0)
             
            Button(action: {
                //Start transfer
            }) {
                Text("Start transfer".localizedUppercase)
                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                    .frame(maxWidth: .infinity)
                    .padding(.all, 10.0)
                    .foregroundColor(Color(UIColor.white))
                    .background(Color(UIColor.liteWalletBlue))
                    .cornerRadius(4.0)

            }
            .padding(.bottom, 10.0)

            // Cancel
            Button(action: {
                self.shouldShow = false
            }) {
                Text(S.Button.cancel.uppercased())
                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.liteWalletBlue))
                    .background(Color(UIColor.white))
                    .cornerRadius(4.0)
                    .padding(.all, 10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.litecoinSilver)
                    )
            }
            Spacer()

        }
        .padding([.leading, .trailing], mainPadding)
        
    }
}

struct TransferAmountSelectionView_Previews: PreviewProvider {
    
    static let viewModel = TransferAmountSelectionViewModel()
    
    static var previews: some View {
        
        Group {
            VStack {
                TransferAmountSelectionView(viewModel: viewModel,
                                            litewalletBalance: 22.15219,
                                            litecoinCardBalance: 50.0,
                                            shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            VStack {
                TransferAmountSelectionView(viewModel: viewModel,
                                            litewalletBalance: 0.0,
                                            litecoinCardBalance: 50.0,
                                            shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            VStack {
                TransferAmountSelectionView(viewModel: viewModel,
                                            litewalletBalance: 223.22301,
                                            litecoinCardBalance: 0.0,
                                            shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}










