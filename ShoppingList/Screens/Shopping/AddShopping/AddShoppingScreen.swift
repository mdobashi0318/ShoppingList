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
                    itemView
                    selectItemForm
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
            .navigationTitle(viewModel.mode == .add ? "購入情報追加" : "購入情報更新" )
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    AddButton {
                        if viewModel.mode == .add {
                            if viewModel.validation() {
                                viewModel.add()
                            }
                        } else {
                            if viewModel.validation() {
                                viewModel.update()
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.alertFlag) {
                switch viewModel.alertType {
                case .success:
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")) {
                        self.dismiss()
                    })
                case .error:                    
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text("閉じる")))
                }
            }
        }
        
    }
    /// アイテム入力フォームかアイテム情報を表示する
    @ViewBuilder
    var itemView: some View {
        if viewModel.mode == .add {
            ItemAddFormView(name: $viewModel.name,
                            price: $viewModel.price
            )
        } else {
            ItemDetailView(name: viewModel.name,
                           price: Int(viewModel.price) ?? 0
            )
        }
    }
    
    /// アイテムをピッカーから選択できるformを表示する
    @ViewBuilder
    var selectItemForm: some View {
        if viewModel.mode == .add {
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
        }
    }
}

#Preview {
    AddShoppingScreen()
}
