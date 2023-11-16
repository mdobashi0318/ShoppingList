//
//  AddShoppingScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/29.
//

import SwiftUI

struct AddShoppingScreen: View {
    
    @StateObject var viewModel = AddShoppingViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                    Section {
                        HStack {
                            TextField("商品名を入力してください", text: $viewModel.name)
                        }
                        
                        HStack {
                            TextField("金額を入力してください", text: $viewModel.price)
                                .keyboardType(.numberPad)
                        }
            
                        Toggle(isOn: $viewModel.inputItem, label: {
                            Text("登録済の商品から選ぶ")
                        })
                        
                        if viewModel.inputItem {
                            Picker("a", selection: $viewModel.itemId) {
                                ForEach($viewModel.model, id: \.id) { item in
                                    Text(item.name.wrappedValue)
                                }
                            }
                            if !viewModel.itemId.isEmpty {
                                Text("¥\(viewModel.model.first(where: { $0.id == viewModel.itemId })?.price ?? 0)")
                            }
                        }
                            
                            
                    } header: {
                        Text("商品")
                    }
                    
                    Section {
                        TextField("個数を入力してください", text: $viewModel.count)
                            .keyboardType(.numberPad)
                    } header: {
                        Text("個数")
                    }
                }
            .navigationTitle("アイテム追加")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    AddButton {
                        
                        if viewModel.validation() {
                            viewModel.add()
                            self.dismiss()
                        }
                        
                    }
                }
            }
            .alert(isPresented: $viewModel.errorFlag) {
                Alert(title: Text(viewModel.errorMessage), dismissButton: .default(Text("閉じる")))
            }
        }
        
    }
}

#Preview {
    AddShoppingScreen()
}
