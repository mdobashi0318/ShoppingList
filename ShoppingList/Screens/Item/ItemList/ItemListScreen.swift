//
//  ItemList.swift
//  ShoppingList
//
//  Created by 土橋正晴 on 2023/11/18.
//

import SwiftUI

struct ItemListScreen: View {
    
    @StateObject private var viewModel = ItemListViewModel()
    
    @State private var addItemSheet = false
    
    var body: some View {
        NavigationStack {
            itemList
                .navigationTitle(R.string.naviTitle.itemList())
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
                .task(id: addItemSheet) {
                    if !addItemSheet {
                        viewModel.fetchItems()
                    }
                }
        }
    }
    
    @ViewBuilder
    private var itemList: some View {
        if viewModel.model.isEmpty {
            Text(R.string.label.noList())
        } else {
            List {
                ForEach($viewModel.model) { item in
                    NavigationLink(value: item.id) {
                        VStack(alignment: .leading) {
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
    ItemListScreen()
}
