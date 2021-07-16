//
//  PreTransferView.swift
//  loafwallet
//
//  Created by Kerry Washington on 7/6/21.
//  Copyright © 2021 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct PreTransferView: View {
    
    let mainPadding: CGFloat = 20.0
    let generalCornerRadius: CGFloat = 12.0
    
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: PreTransferViewModel
    
    @State
    var wasTapped: Bool = false
    
    init(viewModel: PreTransferViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                RoundedRectangle(cornerRadius: generalCornerRadius)
                    .frame(height: 150.0,
                           alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(mainPadding)
                    .foregroundColor(Color.litecoinGray)
                    .shadow(color: wasTapped ? .clear : .gray , radius:2.0, x: 3.0, y: 3.0)
                    .overlay(
                        
                        VStack {
                            
                            HStack {
                                
                                if viewModel.walletType == .litecoinCard {
                                    
                                    Image(viewModel.walletType.description)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100,
                                               height: 72,
                                               alignment:
                                                .leading)
                                        .contrast(0.95)
                                        .shadow(radius: 2.0, x: 3.0, y: 3.0)
                                        .padding(.top, 2.0)
                                        .padding(.leading, mainPadding + 12.0)

                                } else {
                                    
                                    LitewalletIconView()
                                        .padding(.top, 2.0)
                                        .padding(.leading, mainPadding + 12.0)
                                }
                                Spacer()
                            }
                            
                            HStack {
                                
                                Text("\(viewModel.walletType.balanceLabel):")
                                    .foregroundColor(.black)
                                    .font(Font(UIFont.barlowSemiBold(size: 20.0)))
                                    .padding(.leading, mainPadding + 12.0)

                                Text("\(viewModel.balance) Ł")
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font(UIFont.barlowRegular(size: 22.0)))
                                    .padding(.leading, 10.0)
                                
                                Spacer()
                            }
                        }
                    )
                
                VStack {
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("GGGG")
                        }) {
                             
                            Text(viewModel.balance == 0.0 ? "--" : S.LitecoinCard.Transfer.title.localizedUppercase)
                                .frame(width: 180.0,
                                       height: 50.0,
                                       alignment: .center)
                                .font(Font(UIFont.barlowRegular(size: 22.0)))
                                .foregroundColor(viewModel.balance == 0.0 ? .gray : .white)
                                .background(viewModel.balance == 0.0 ? Color.litewalletLightGray : Color.liteWalletBlue)
                        }
                        .cornerRadius( generalCornerRadius, corners: [.topRight, .bottomLeft])
                        .disabled(viewModel.balance == 0.0 ? true : false)
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 150.0,
                       alignment: .center)
                .frame(maxWidth: .infinity)
                .padding([.trailing], mainPadding)
            }

            
        }
    }
}

struct PreTransferView_Previews: PreviewProvider {
    
    static let lcImagestr = MockData.cardImageString
    static let lwImagestr = MockData.logoImageString
    static let small = MockData.smallBalance
    static let large = MockData.largeBalance
    
    static let lcViewModel = PreTransferViewModel(walletType: .litecoinCard, balance: small)
    
    static let lwViewModel = PreTransferViewModel(walletType: .litewallet, balance: large)
    
    static let zerolcViewModel = PreTransferViewModel(walletType: .litecoinCard, balance: 0.0)
    
    static let zerolwViewModel = PreTransferViewModel(walletType: .litewallet, balance: 0.0)
    static var previews: some View {
        
        Group {
            VStack {
                PreTransferView(viewModel: lcViewModel)
                PreTransferView(viewModel: lwViewModel)
                PreTransferView(viewModel: zerolcViewModel)
                PreTransferView(viewModel: zerolwViewModel)
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            VStack {
                PreTransferView(viewModel: lcViewModel)
                PreTransferView(viewModel: lwViewModel)
                PreTransferView(viewModel: zerolcViewModel)
                PreTransferView(viewModel: zerolwViewModel)
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            VStack {
                PreTransferView(viewModel: lcViewModel)
                PreTransferView(viewModel: lwViewModel)
                PreTransferView(viewModel: zerolcViewModel)
                PreTransferView(viewModel: zerolwViewModel)
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}








