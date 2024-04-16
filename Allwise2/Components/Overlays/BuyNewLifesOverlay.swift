//
//  BuyNewLifesOverlay.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//

import SwiftUI

enum ItemSelected {
    case buyMonthlySub
    case lifeRefill
}

struct BuyNewLifesOverlay: View {
    
    var onContinueLearning: () -> Void
    var onEndSession: () -> Void
    
    @State var isBuyPremiumSelected : Bool = false
    @State var isBackToMenuSelected: Bool = false
    
    @State private var selectedItem : ItemSelected = .buyMonthlySub
    
    @State var moveToSubsciptionShopView = false
    @State var moveToRefillLifesShopView = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 8) {
                
                Text("You ran out of hearts!")
                    .bold()
                    .font(.title2)
                    .padding()
                
                GradientBorderButton(
                    isSelected: selectedItem == .buyMonthlySub,
                                    item: .buyMonthlySub,
                                    action: { 
                                        selectItem(.buyMonthlySub)
                                    })
                  
                  GradientBorderButton(
                    isSelected : selectedItem == .lifeRefill,
                                       item: .lifeRefill,
                                       action: { selectItem(.lifeRefill)
                                       })
                                    
                VStack{
                        ContinueButton(content: 
                                        content(),
                                       backgroundColor: .duoBlue,
                                       shadowGroundColor: .darkBlue) {
                            LifesManager.shared.refillLifes(count: 5)
                        }
                                       
                    
                        Button("No thanks", action: onEndSession)
                            .bold()
                            .font(.title3)
                            .foregroundStyle(.duoBlue)
                    
                }
            }
            .fontDesign(.rounded)
            .frame(maxWidth: .infinity)
            .background(.duoWhite)
            .foregroundStyle(.reverseWhite)
        }
        .transition(.move(edge: .bottom))
        .fullScreenCover(isPresented: $moveToSubsciptionShopView) {
            ShopView(productType:.subscription)
                .environmentObject(StoreKitManager.shared)
        }
        .fullScreenCover(isPresented: $moveToRefillLifesShopView) {
            ShopView(productType:.consumable)
                .environmentObject(StoreKitManager.shared)
        }
    }
    
    func moveToTheSelectShopView() {
        switch selectedItem {
        case .buyMonthlySub:
            moveToSubsciptionShopView = true
        case .lifeRefill:
            moveToRefillLifesShopView = true
        }
    }
    
    func content() -> String {
        switch selectedItem {
        case .buyMonthlySub:
            return "Unlimited"
        case .lifeRefill:
            return "Refill Lifes"
        }
    }
 
    private func selectItem(_ item: ItemSelected) {
        withAnimation(.snappy) {
            selectedItem = item
        }
    }
}

#Preview {
    BuyNewLifesOverlay(onContinueLearning: {}, onEndSession: {})
}


struct GradientBorderButton: View {
    
    let linearGradient = Constants.premiumLinearGradient
    
    let isSelected : Bool
    
    let item : ItemSelected
    
    var action: () -> Void
    
    var body: some View {
            HStack {
                
                icon()
                
                Text(title())
                    .bold()
                
                Spacer()
                
                Text(catchPhrase())
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(linearGradient)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10) // Use the corner radius you want here
                .stroke(isSelected ? linearGradient : LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
            .padding()
            .onTapGesture {
                withAnimation(.snappy){
                    action()
                }
            }
    }
    
    func icon() -> some View {
        switch item {
        case .buyMonthlySub:
            return ZStack {
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundStyle(linearGradient)
                Image(systemName: "infinity")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .bold()
            }
        case .lifeRefill:
            return ZStack {
                Image(systemName: "heart")
                    .font(.largeTitle)
                    .foregroundStyle(linearGradient)
                Image(systemName: "")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
    
    func title() -> String {
        switch item {
        case .buyMonthlySub:
            return "Unlimited Hearts"
        case .lifeRefill:
            return "Refill your lifes"
        }
    }

    func catchPhrase() -> String {
        switch item {
        case .buyMonthlySub:
            return "GET SUPER"
        case .lifeRefill:
            return "ONE SHOT"
        }
    }
}

class Constants {
    static let premiumGradient = Gradient(colors: [.green, .blue, .purple, .pink])
    static let premiumLinearGradient =  LinearGradient(gradient: premiumGradient, startPoint: .leading, endPoint: .trailing)
}
