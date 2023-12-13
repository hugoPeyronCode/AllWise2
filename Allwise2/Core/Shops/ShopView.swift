//
//  ShopView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 29/11/2023.
//

import SwiftUI
import StoreKit

struct ShopView: View {
    
    enum ProductType {
        case subscription
        case consumable
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var storeKitManager : StoreKitManager
    
    let productType: ProductType
    
    @State private var showCancelButton = false
    
    @State private var selectedProduct : Product?
    
    let termsAndConditionsURL = URL(string: "https://www.notion.so/APPLICATION-TERMS-AND-CONDITIONS-OF-USE-AND-PRIVACY-POLICY-431520373299481a97353288b54489f5?pvs=4")!
    
    var body: some View {
        ZStack {
            
            if storeKitManager.isLoading { LoadingSymbol }
            
            VStack {
                HStack {
                    CancelButton
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                
                HeaderText
                
                Spacer()
                
                if productType == .subscription { AdvantagesList }
                
                Spacer()
                
                ProductsSelection
                
                Spacer()
                
                ContinueButton
                
                FooterOption
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            Task {
                do {
                    try await storeKitManager.loadProducts()
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    var LoadingSymbol : some View {
        ProgressView() // Show loading symbol when isLoading is true
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 150))
            .tint(.blue)
            .scaleEffect(2)
    }
    
    var CancelButton : some View {
        Button {
            dismiss()
        } label: {
            if showCancelButton {
                Image(systemName: "xmark")
                    .foregroundStyle(.gray.opacity(0.4))
                    .font(.subheadline)
            }
        }
        .onAppear {
            if storeKitManager.isLoading == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showCancelButton = true
                }
            }
        }
    }
    
    var HeaderText: some View {
        VStack(spacing: 10) {
            switch productType {
            case .subscription:
                Text("Try Super Allwise")
                    .font(.title)
                    .bold()
                Text("Unlock everything")
                    .font(.title2)
                    .bold()
            case .consumable:
                Text("Buy Extra Lifes")
                    .font(.title)
                    .bold()
                Text("Stay in the game longer")
                    .font(.title2)
                    .bold()
            }
        }
        .padding()
    }
    
    var ProductsSelection: some View {
        HStack {
            ForEach(storeKitManager.products, id: \.self) { product in
                if shouldDisplayProduct(product) {
                    Button {
                        selectedProduct = product
                    } label: {
                        VStack {
                            ProductView(product: product, isSelected: selectedProduct == product)
                        }
                    }
                    .onAppear {
                        if productType == .subscription && product.displayName == "AllwiseMonthlySub" {
                            selectedProduct = product
                        }
                    }
                }
            }
        }
    }
    
    // Additional helper method to determine if a product should be displayed
    private func shouldDisplayProduct(_ product: Product) -> Bool {
        switch productType {
        case .subscription:
            return storeKitManager.subProductIds.contains(product.id)
        case .consumable:
            return storeKitManager.consumableProductIds.contains(product.id)
        }
    }

    
    var Crown : some View {
        Image("Premium")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
    
    var AdvantagesList : some View {
        VStack(alignment: .leading, spacing: 15){
            Advantage(text: "Enjoy the full experience")
            Advantage(text: "Unlimited number of lifes")
            Advantage(text: "No ads, no Watermarks")
        }
    }
    
    var ContinueButton : some View {
        Button {
            if let product = selectedProduct {
                Task {
                    do {
                        print("Trying to purchase a \(product.debugDescription)")
                        try await storeKitManager.purchase(product)
                        if storeKitManager.hasUnlockedPremium == true {
                        dismiss()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        } label: {
            if let selectedProductName = selectedProduct {
                Text("\(productType == .consumable ? "Buy" : "Subscribe for") \(selectedProductName.displayName)")
            } else {
                Text("Select a product")
            }
        }
    }
    
    var FooterOption : some View {
        HStack(spacing: 60) {
            Button {
                Task {
                    do {
                        try await AppStore.sync()
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Restore")
            }
            
            Link(destination: termsAndConditionsURL) {
                Text("Terms & Conditions")
            }
            .font(.caption2)
            .foregroundColor(.gray)
            
        }
        .font(.caption2)
        .foregroundColor(.gray)
    }
}

#Preview {
    ShopView(productType: .subscription)
        .environmentObject(StoreKitManager())
}


struct Advantage : View {
    let text : String
    
    var body : some View {
        HStack{
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.black, Color.duoBlue)
            Text(text)
        }
    }
}

struct ProductView: View {
    let product: Product
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 40) {
            Text(product.displayName.capitalized)
            Text("\(product.displayPrice)")
                .bold()
        }
        .font(.subheadline)
        .padding()
        .frame(width: 100)
        .foregroundStyle(.black)
        .background(isSelected ? .duoBlue : .duoBlue.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.duoBlue, lineWidth: 2)
        )
    }
}
