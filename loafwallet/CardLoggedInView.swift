//
//  CardLoggedInView.swift
//  loafwallet
//
//  Created by Kerry Washington on 12/26/20.
//  Copyright © 2020 Litecoin Foundation. All rights reserved.
//

import SwiftUI

struct CardLoggedInView: View {
    
    //MARK: - Combine Variables
    @ObservedObject
    var viewModel: CardViewModel
    
    @ObservedObject
    var animatedViewModel = AnimatedCardViewModel()
    
    @State
    private var shouldLogout: Bool = false
    
    @State
    var balanceText = ""
    
    @State
    var walletBalancesStatus: WalletBalanceStatus = .litewalletAndCardEmpty
    
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                Button(action: {
                    shouldLogout = true
                    viewModel.isLoggedIn = false
                    NotificationCenter.default.post(name: .LitecoinCardLogoutNotification,
                                                    object: nil,
                                                    userInfo: nil)
                    
                }) {
                    Text(S.LitecoinCard.logout)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .center)
                        .font(Font(UIFont.barlowSemiBold(size: 22.0)))
                        .foregroundColor(Color(UIColor.liteWalletBlue))
                        .cornerRadius(8.0)
                        .padding(.all, 50.0)
                }
                
                Text(S.LitecoinCard.Transfer.description)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .center)
                    .font(Font(UIFont.barlowLight(size: 30.0)))
                    .foregroundColor(Color(UIColor.liteWalletBlue))
                    .padding([.top,.leading,.trailing], 50)
                    .padding(.bottom, 10)

 
                VStack {
                    walletViewStack()
                    Spacer()
                }
                .padding(.top, 30.0)
                 
                Spacer()
                pagingIndicatorView()
            }
        }
    }
    
    func walletViewStack() -> AnyView {
    
    guard let cardBalance = viewModel.cardWalletDetails?.availableBalance else {
        return AnyView(EmptyView())
    }
    
    let litewalletBalance = viewModel.litewalletAmount.amountForLtcFormat
        
    switch viewModel.walletBalanceStatus {
        
        case .litewalletAndCardEmpty:
            return AnyView (
                
                VStack {
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litecoinCard,
                                                             balance: cardBalance))
 
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litewallet,
                                                             balance: litewalletBalance))

                    Spacer()

                }
            )
        case .cardWalletEmpty:
            return AnyView(
                VStack {
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litewallet,
                                                             balance: litewalletBalance))
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litecoinCard,
                                                             balance: cardBalance))
                }
            )
        case .litewalletEmpty:
            return AnyView(
                VStack {
                    
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litecoinCard,
                                                             balance: cardBalance))
                    
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litewallet,
                                                             balance: litewalletBalance))
                        
                    Spacer()

                }
            )
        case .litewalletAndCardNonZero:
            return AnyView(
                VStack {
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litecoinCard,
                                                                    balance: cardBalance))
                    
                    PreTransferView(viewModel:
                                        PreTransferViewModel(walletType: .litewallet,
                                                             balance: litewalletBalance))
                          

                    Spacer()
                }
            )
        case .none:
            return AnyView(Spacer())
    }
}
    
    func pagingIndicatorView() -> AnyView {
        
        return AnyView (
            HStack {
                Ellipse().fill(Color.liteWalletBlue).frame(width: 10, height: 10)
                Ellipse().fill(Color.litecoinGray).frame(width: 10, height: 10)
            }
            .padding(.all, 40.0)
        )
    }
     
}



struct CardLoggedInView_Previews: PreviewProvider {
    
    static let amount100 = MockSeeds.amount100
    
    static let viewModel = CardViewModel(litewalletAmount: amount100)
    
    static var previews: some View {
        Group {
            CardLoggedInView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhoneSE2))
                .previewDisplayName(DeviceType.Name.iPhoneSE2)
            
            CardLoggedInView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone8))
                .previewDisplayName(DeviceType.Name.iPhone8)
            
            CardLoggedInView(viewModel: viewModel)
                .previewDevice(PreviewDevice(rawValue: DeviceType.Name.iPhone12ProMax))
                .previewDisplayName(DeviceType.Name.iPhone12ProMax)
        }    }
}




