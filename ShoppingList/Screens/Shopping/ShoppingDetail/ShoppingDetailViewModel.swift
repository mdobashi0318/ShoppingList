//
//  ShoppingDetailViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/11.
//

import Foundation

class ShoppingDetailViewModel: ObservableObject {
    
    @Published var shopping = Shopping()
    
    @Published var item = Item()
    
    @Published var purchased = false
    
    private(set) var id = ""
    
    @Published var alertFlag = false
    
    private(set) var alertType: AlertType = .success
    
    private(set) var alertMessage = ""
    
    
    init(id: String) {
        self.id = id
        fetchShopping()
        fetchItem()
    }
    
    func fetchShopping() {
        do {
            shopping = try Shopping.fetch(id: id)
            purchased = shopping.purchased == PurchaseStatus.purchased.rawValue ? true : false
        } catch {
            alertMessage = R.string.label.notFound()
        }
    }

    
    private func fetchItem() {
        do {
            item = try Item.fetch(id: shopping.itemId)
        } catch {
            setAlert(type: .error, message: R.string.label.notFound())
        }
    }
    
    
    func updatePurchaseStatus() {
        try? Shopping.updatePurchaseStatus(id: id, status: purchased)
    }
    
    
    func delete() {
        do {
            try Shopping.delete(shopping)
            shopping = Shopping()
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
