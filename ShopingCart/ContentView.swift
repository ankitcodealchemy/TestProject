//
//  ContentView.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var productsArray = [ProductModelClass]()
    @State var addedCartCount : Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                HStack{
                    Text("")
                        .frame(width: 20, height: 20)
                        .padding()
                    Spacer()
                    Text("Product List")
                        .font(.headline)
                    Spacer()
                    NavigationLink(destination: ProductCartView()
                                    .navigationBarHidden(true)) {
                        
                        Image(systemName: "cart")
                            .resizable()
                            .overlay(Badge(count: addedCartCount))
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding()
                    }
                }
                Spacer()
                VStack(spacing:0){
                    if productsArray.count > 0 {
                        ScrollView {
                            ForEach(productsArray) { productData in
                                NavigationLink(destination: ProductDetailView(product_id: productData.id)
                                                .navigationBarHidden(true)) {
                                    ProductListCellView(productData: productData)
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Text("Load Products")
                            .bold()
                        Spacer()
                    }
                }
                .padding([.top, .bottom],10)
                .ignoresSafeArea()

            }
            .navigationBarHidden(true)
            .onAppear {
                ProductListApi().loadProductList { productListArray in
                    productsArray = productListArray
                }
                addedCartCount = CartStorageManager.sharedManager.getCartProductTotalCount()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
