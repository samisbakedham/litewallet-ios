//
//  TransferAmountView.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct TransferAmountView: View {
    
    let mainPadding: CGFloat = 40.0
    let smallButtonSize: CGFloat = 25.0
    
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: TransferAmountViewModel
    
    @Binding
    var shouldShow: Bool
    
    @State
    private var newBalance: Double = 0.0
     
    @State
    private var transferAmount: Double = 0.0
    
    //MARK: - Private Variables
    
    private let walletStatus: WalletBalanceStatus
    
    private let transferWallet: WalletType
    
    init(viewModel: TransferAmountViewModel,
         litewalletBalance: Double,
         litecoinCardBalance: Double,
         transferWalletType:  WalletType,
         walletStatus: WalletBalanceStatus,
         shouldShow: Binding<Bool>) {
        
        self.walletStatus = walletStatus
        
        self.transferWallet = transferWalletType
        
        viewModel.litewalletBalance = litewalletBalance
        
        viewModel.litecoinCardBalance = litecoinCardBalance
        
        self.viewModel = viewModel
        
        _shouldShow = shouldShow
        
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(transferWallet.balanceLabel + ": ")
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                
                Spacer()
                
                Text(viewModel.newBalanceString + " Ł")
                    .font(Font(UIFont.barlowLight(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
            }
            
            HStack {
                Text(S.LitecoinCard.Transfer.amount + ": ")
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                
                Spacer()
                
                Text(String(format:"%5.4f", transferAmount) + " Ł")
                    .font(Font(UIFont.barlowLight(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
            }
            
            //Underline view
            Divider()
            
            HStack {
                Text(transferWallet.newBalanceLabel + ": ")
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                Spacer()
                Text(String(newBalance) + " Ł")
                    .font(Font(UIFont.barlowLight(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
            }
            .padding(.bottom, 20.0)
            
            Group {
                
                HStack {
                     
                    //Decrease
                    Button(action: {
                        //1x +
                    }) {
                        VStack {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: smallButtonSize,
                                       height: smallButtonSize,
                                       alignment: .center)
                                .foregroundColor(.liteWalletBlue)
                                .shadow(color: .litecoinSilver, radius: 1.0, x: 2.0, y: 2.0)
                        }
                    }
                     
                    Slider(value: $transferAmount, in: 0...1,
                           step: 0.01)
                        .accentColor(.liteWalletBlue)
                        .onAppear() {
                        self.transferAmount = 0.0
                        }
                        .padding()
                    
                    //Increase
                    Button(action: {
                    //1x +
                    }) {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: smallButtonSize,
                                       height: smallButtonSize,
                                       alignment: .center)
                                .foregroundColor(.liteWalletBlue)
                                .shadow(color: .litecoinSilver, radius: 1.0, x: 2.0, y: 2.0)
                        }
                    }
                }
                .padding(.bottom, 20.0)
            }
            
            //Start transfer
            Button(action: {
                //API Call to the backend
            }) {
                Text(S.LitecoinCard.Transfer.startTransfer.localizedUppercase)
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .frame(maxWidth: .infinity)
                    .padding(.all, 8.0)
                    .foregroundColor(Color(UIColor.white))
                    .background(Color(UIColor.liteWalletBlue))
                    .cornerRadius(4.0)
                
            }
            .padding(.bottom, 5.0)
            
            // Cancel
            Button(action: {
                self.shouldShow = false
            }) {
                Text(S.Button.cancel.uppercased())
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.liteWalletBlue))
                    .background(Color(UIColor.white))
                    .cornerRadius(4.0)
                    .padding(.all,  8.0)
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

struct TransferAmountView_Previews: PreviewProvider {
    
    static let viewModel = TransferAmountViewModel()
    
    static var previews: some View {
        
        Group {
            VStack {
                TransferAmountView(viewModel: viewModel,
                                   litewalletBalance: 22.15219,
                                   litecoinCardBalance: 50.0,
                                   transferWalletType: .litewallet,
                                   walletStatus: .cardWalletEmpty,
                                   shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            VStack {
                TransferAmountView(viewModel: viewModel,
                                   litewalletBalance: 0.0,
                                   litecoinCardBalance: 50.0,
                                   transferWalletType: .litecoinCard,
                                   walletStatus: .litewalletEmpty,
                                   shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            VStack {
                TransferAmountView(viewModel: viewModel,
                                   litewalletBalance: 223.22301,
                                   litecoinCardBalance: 0.0,
                                   transferWalletType: .litewallet,
                                   walletStatus: .litewalletAndCardNonZero,
                                   shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}

