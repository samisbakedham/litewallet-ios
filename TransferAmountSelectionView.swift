//
//  TransferAmountSelectionView.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/17/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct TransferAmountSelectionView: View {
    
    let mainPadding: CGFloat = 20.0
 
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: TransferAmountSelectionViewModel
    
    @Binding
    var shouldShow: Bool
    
    @State
    var transferAmount: Double = 0.0
    
    @State
    var transferAmountString: String = ""
    
    init(viewModel: TransferAmountSelectionViewModel, shouldShow: Binding<Bool>) {
        
        _shouldShow = shouldShow
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button(action: {
                self.shouldShow = false
            }, label: {
                HStack {
                    
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25,
                               alignment: .leading)
                        .foregroundColor(Color.liteWalletBlue)
                        .padding()
                    
                    Spacer()
                }
            })
            
            HStack {
                Text("Current Balance")
                Text("30002")
                Spacer()
            }
            
            HStack {
                Text("Current Balance")
                Text("30002")
                Spacer()
            }
            
            TextField("Enter amount to transfer", text: $transferAmountString) { (changedValue) in
                print("\(changedValue)")
            } onCommit: {
                print("committed")
                
            }.font(Font(UIFont.barlowRegular(size: 16.0)))
            .keyboardType(.decimalPad)
            .padding([.leading, .trailing, .top], mainPadding)
            .padding(.top, 12)
            
            // Copy the LF Address and paste into the SendViewController
            Button(action: {
                UIPasteboard.general.string = FoundationSupport.supportLTCAddress
            }) {
                Text("Start transfer".localizedUppercase)
                    .font(Font(UIFont.barlowSemiBold(size: 16.0)))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.white))
                    .background(Color(UIColor.liteWalletBlue))
                    .cornerRadius(4.0)
            }
            .padding([.leading, .trailing], mainPadding)
            .padding(.bottom, 15)
            
            // Cancel
            Button(action: {
                //
            }) {
                Text(S.Button.cancel.uppercased())
                    .font(Font(UIFont.customMedium(size: 16.0)))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(UIColor.liteWalletBlue))
                    .background(Color(UIColor.white))
                    .cornerRadius(4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.secondaryBorder))
                    )
            }
            .padding([.leading, .trailing], mainPadding)
            
            
            Spacer()
        }
        .padding()
        
        
    }
}

struct TransferAmountSelectionView_Previews: PreviewProvider {
    
    static let viewModel = TransferAmountSelectionViewModel()
    
    static var previews: some View {
        
        Group {
            VStack {
                TransferAmountSelectionView(viewModel: viewModel, shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            VStack {
                TransferAmountSelectionView(viewModel: viewModel, shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            VStack {
                TransferAmountSelectionView(viewModel: viewModel, shouldShow: .constant(true))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}










