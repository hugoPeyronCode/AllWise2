//
//  StoreKitManager.swift
//  Allwise2
//
//  Created by Hugo Peyron on 28/11/2023.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
class StoreKitManager : ObservableObject {
    
    static let shared = StoreKitManager()
    let lifesManager = LifesManager.shared
    
    let subProductIds = ["AllwiseYearlySub", "AllwiseMonthlySub", "AllwiseWeeklySub"]
    let consumableProductIds = ["5Lifes", "20Lifes", "50Lifes"]
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()
    @Published var isLoading = false
    private var productsLoaded = false
    
    private var updates: Task<Void, Never>? = nil
    
    init() {
        self.updates = observeTransactionUpdates()
        print("purchasedProductIds.count = \(purchasedProductIDs.count)")
    }
    
    deinit {
        self.updates?.cancel()
    }
    
    var hasUnlockedPremium = true
//    Bool {
////        print("has unlocked Premium")
//        return !self.purchasedProductIDs.isEmpty
//    }
    
    func loadProducts() async throws {
        // If products already loaded do nothing
        guard !self.productsLoaded else { return }
        
        // Regroupd all products in one array
        let allProductIds = subProductIds + consumableProductIds
        
        // Fill the products array of products with the product using the storeKit Api call.
        self.products = try await Product.products(for: allProductIds)
        self.productsLoaded = true
    }
    
    func purchase(_ product: Product) async throws {
        // Save the state of the purchase in a the isLoading variable
        self.isLoading = true
               defer { self.isLoading = false } // Ensure isLoading is set to false when the purchase is completed, even if an error occurs
        
        // Save the result of the purchase in a variable
        let result = try await product.purchase()
        
        switch result {
        case let .success(.verified(transaction)):
            print("Successful purchase")
            if consumableProductIds.contains(transaction.productID) {
                // Update user's balance for consumable product
                handleConsumablePurchase(productID: transaction.productID)
            } else {
                // Handle subscription purchase
                await self.updatePurchasedProducts()
            }
            await transaction.finish()
        case .success(.unverified(_, _)):
            // Successful purchase but transaction / receipt can't be verified
            // Could be a jailbroken phone. A cheat.
            print("Unverified purchase")
            break
            
        case .pending:
            print("transation is pending ")
            break
            
        case .userCancelled:
            print("User cancelled")
            break
        @unknown default:
            break
        }
    }
    
    private func handleConsumablePurchase(productID: String) {
        // Update user balance based on productID
        // For example, if productID is "5Lifes", add 5 lives to user's balance
        switch productID {
        case "5Lifes":
            lifesManager.refillLifes(count: 5)
        case "20Lifes":
            lifesManager.refillLifes(count: 20)
        case "50Lifes":
            lifesManager.refillLifes(count: 50)
        default:
            print("No product id found")
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                // _ to replace -> verificationResult directly would be better
                await self.updatePurchasedProducts()
            }
        }
    }
    
}
