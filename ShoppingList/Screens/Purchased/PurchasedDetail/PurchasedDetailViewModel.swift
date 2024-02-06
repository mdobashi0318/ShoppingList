//
//  PurchasedDetailViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2024/02/06.
//

import Foundation

class PurchasedDetailViewModel: ObservableObject {
    
    @Published var purchasedItem = PurchasedItem()
        
    @Published var purchased = true
    
    private(set) var id = ""
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
    
    init(id: String) {
        self.id = id
        fetch()
    }
    
    func fetch() {
        do {
            purchasedItem = try PurchasedItem.fetch(id: id)
        } catch {
            alertMessage = R.string.label.notFound()
        }
    }
    
    
    func delete() {
        do {
            try PurchasedItem.delete(purchasedItem)
            purchasedItem = PurchasedItem()
        } catch {
            setAlert(type: .error, message: R.string.alertMessage.deletionFailed())
        }
    }
    
    
    func setAlert(type: AlertType, message: String) {
        alertType = type
        alertMessage = message
        alertFlag = true
    }
}
