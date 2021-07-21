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
     
    var transferAmountTo: String {
        return viewModel.walletType == .litewallet ?
            S.LitecoinCard.Transfer.amountToCard :
            S.LitecoinCard.Transfer.amountToLitewallet
    }
    
    @State
    var sliderValue: Double = 0.0
     
    var calculatedValue: Double {
        return viewModel.currentBalance * sliderValue
    }
    
    var remainingBalance: Double {
        return (viewModel.currentBalance - (viewModel.currentBalance * sliderValue)) ?? 0.0
    }
    
    
      
    init(viewModel: TransferAmountViewModel,
         shouldShow: Binding<Bool>) {
          
        self.viewModel = viewModel
        
        _shouldShow = shouldShow
        
    }
    
    var body: some View {
        
        VStack {
            
            //Balance Amount
            HStack {
                Text(viewModel.walletType.balanceLabel + ": ")
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                
                Spacer()
                
                Text(String(format:"%5.4f", remainingBalance) + " Ł")
                    .font(Font(UIFont.barlowLight(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                    .padding(.trailing, 5.0)
            }
            
            //Transfer Amount
            HStack {
                Text(transferAmountTo + ": ")
                    .font(Font(UIFont.barlowSemiBold(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                
                Spacer()
                
                Text(String(format:"%5.4f", calculatedValue) + " Ł")
                    .font(Font(UIFont.barlowLight(size: 18.0)))
                    .foregroundColor(Color.liteWalletBlue)
                    .padding(.trailing, 5.0)

            }
            
            //Underline view
            Divider()
              
            //Amount Slider
            Group {
                
                HStack {
                     
                    Image(systemName: "minus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: smallButtonSize,
                               height: smallButtonSize,
                               alignment: .center)
                        .foregroundColor(.liteWalletBlue)

                    Slider(value: $sliderValue, in: 0...1,
                           step: 0.01)
                        .accentColor(.liteWalletBlue)
                        .padding()
                    
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: smallButtonSize,
                               height: smallButtonSize,
                               alignment: .center)
                        .foregroundColor(.liteWalletBlue)
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
    
    static let lwPlusviewModel = TransferAmountViewModel(walletType: .litewallet, walletStatus: .cardWalletEmpty, litewalletBalance: 520.0, cardBalance: 0.0)
    
    static let cardPlusviewModel = TransferAmountViewModel(walletType: .litecoinCard, walletStatus: .litewalletEmpty, litewalletBalance: 0.0, cardBalance: 0.0555)
    
    static let lwlcPlusviewModel = TransferAmountViewModel(walletType: .litewallet, walletStatus: .cardWalletEmpty, litewalletBalance: 520.0, cardBalance: 56.0)
    
    static var previews: some View {
        
        Group {
               
            TransferAmountView(viewModel: lwPlusviewModel,
                                   shouldShow: .constant(true))
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            TransferAmountView(viewModel: cardPlusviewModel,
                                   shouldShow: .constant(true))
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            TransferAmountView(viewModel: lwlcPlusviewModel,
                               shouldShow: .constant(true))
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            TransferAmountView(viewModel: lwlcPlusviewModel,
                                   shouldShow: .constant(true))
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}

