//
//  AddItemViewModel.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/19.
//

import Foundation


class AddItemViewModel: ObservableObject {
    
    @Published var name: String = ""
    
    @Published var price: String = ""
    
    
    @Published var errorFlag = false
    
    var errorMessage = ""
    
    func validation() -> Bool {
        if name.isEmpty {
            errorMessage = "商品名が入力されていません"
            errorFlag = true
            return false
        } else if price.isEmpty {
            errorMessage = "金額が入力されていません"
            errorFlag = true
            return false
        }
        
        errorFlag = false
        return true
    }
    
    func add() { }
}
