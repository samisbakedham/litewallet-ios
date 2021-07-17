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
    
    @Binding
    var wasTapped: Bool
    
    init(viewModel: PreTransferViewModel, wasTapped: Binding<Bool>) {
        
        _wasTapped = wasTapped
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
                    .shadow(radius: 2.0, x: 3.0, y: 3.0)
                    .overlay(
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                if viewModel.walletType == .litecoinCard {
                                    
                                    Image(viewModel.walletType.description)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 110,
                                               height: 72,
                                               alignment:
                                                .center)
                                        .contrast(0.95)
                                        .padding(.top, 2.0)
                                     
                                } else {
                                    
                                    LitewalletIconView()
                                        .padding(.top, 2.0)
                                }
                                
                                Text("Litecoin Card")
                                    .frame(width: 110,
                                           height: 44.0,
                                           alignment: .center)
                                    .font(Font(viewModel.balance == 0.0 ? UIFont.barlowLight(size: 18.0) : UIFont.barlowSemiBold(size: 20.0)))
                                    .foregroundColor(Color.liteWalletDarkBlue)
                            }
                            .padding(.leading, mainPadding)
                            
                            
                            
                            VStack {
                                
                                Text("\(viewModel.balance) Ł")
                                    .foregroundColor(viewModel.balance == 0.0 ? .litecoinSilver : .liteWalletDarkBlue)
                                    .multilineTextAlignment(.leading)
                                    .font(Font(UIFont.barlowRegular(size: 22.0)))
                                    .padding(.leading, 10.0)
                            }
                            
                        }
                        
                    ) 
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
                PreTransferView(viewModel: lcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: lwViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolwViewModel, wasTapped: .constant(false))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
            .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            VStack {
                PreTransferView(viewModel: lcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: lwViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolwViewModel, wasTapped: .constant(false))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
            .previewDisplayName(DeviceType.Name.iPhone8)
            
            VStack {
                PreTransferView(viewModel: lcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: lwViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolcViewModel, wasTapped: .constant(false))
                PreTransferView(viewModel: zerolwViewModel, wasTapped: .constant(false))
                Spacer()
            }
            .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
            .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }
    }
}










