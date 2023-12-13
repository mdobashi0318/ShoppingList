//
//  ItemList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/18.
//

import SwiftUI

struct ItemListScreen: View {
    
    @StateObject var viewModel = ItemListViewModel()
    
    @State var addItemSheet = false
    
    let tab: Tabs
    
    var body: some View {
        NavigationStack {
            itemList
                .navigationTitle(tab.rawValue)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        AddButton(action: {
                            addItemSheet.toggle()
                        })
                    }
                }
                .sheet(isPresented: $addItemSheet) {
                    AddItemScreen()
                        .onDisappear {
                            viewModel.fetchItems()
                        }
                }
                .navigationDestination(for: String.self) { itemId in
                    ItemDetailScreen(viewModel: ItemDetailViewModel(itemId: itemId))
                }
        }
    }
    
    @ViewBuilder
    private var itemList: some View {
        if viewModel.model.isEmpty {
            Text("リストにアイテムがありません")
        } else {
            List {
                ForEach($viewModel.model) { item in
                    NavigationLink(value: item.id) {
                        VStack {
                            Text(item.name.wrappedValue)
                            Text("¥\(item.price.wrappedValue)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ItemListScreen(tab: Tabs.itemList)
}
