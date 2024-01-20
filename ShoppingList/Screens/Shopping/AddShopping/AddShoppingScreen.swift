//
//  AddShoppingScreen.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/10/29.
//

import SwiftUI

struct AddShoppingScreen: View {
    
    @StateObject var viewModel = AddShoppingViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                itemSection
                quantitySection
            }
            .navigationTitle(viewModel.mode == .add ? R.string.naviTitle.purchaseInformationAdded() : R.string.naviTitle.purchaseInformationUpdate() )
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
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.button.close())) {
                        self.dismiss()
                    })
                case .error, .confirm:
                    Alert(title: Text(viewModel.alertMessage), dismissButton: .default(Text(R.string.button.close())))
                }
            }
        }
    }
    
    /// 商品情報を入力するセクション
    private var itemSection: some View {
        Section {
            itemView
            selectItemForm
        } header: {
            Text(itemSectionHeader)
        }
    }
    
    /// itemSectionのheaderの文字列
    private var itemSectionHeader: String {
        if viewModel.mode == .update {
            R.string.label.goods() + "(\(R.string.label.productInformationCannotBeChangedHere()))"
        } else {
            R.string.label.goods()
        }
    }
    
    /// 数量を入力するセクション
    private var quantitySection: some View {
        Section {
            TextField(R.string.label.pleaseEnterTheQuantity(), text: $viewModel.count)
                .keyboardType(.numberPad)
        } header: {
            Text(R.string.label.quantity())
        }
    }
    
    /// アイテム入力フォームかアイテム情報を表示する
    @ViewBuilder
    private var itemView: some View {
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
                Text(R.string.label.selectFromRegisteredProducts())
            })
            
            if viewModel.inputItem {
                Picker("", selection: $viewModel.itemId) {
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
