//
//  ProductCartView.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import SwiftUI

struct ProductCartView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var productsCartArray = [ProductCartModelClass]()
    
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                HStack{
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 20)
                            .padding()
                    }
                    Spacer()
                    Text("Cart")
                        .font(.headline)
                    Spacer()
                    Text("")
                        .frame(width: 20, height: 20)
                        .padding()
                }
                Spacer()
                VStack(spacing:0){
                    if productsCartArray.count > 0 {
                        ScrollView {
                            ForEach(productsCartArray) { productData in
                                NavigationLink(destination: ProductDetailView(product_id: productData.id)
                                                .navigationBarHidden(true)) {
                                    ProductCartCellView(productData: productData)
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Text("No Product Added to Cart")
                            .bold()
                        Spacer()
                        Spacer()
                    }
                }
                .padding([.top, .bottom],10)
                .ignoresSafeArea()
            }
            .navigationBarHidden(true)
            .onAppear {
                productsCartArray = CartStorageManager.sharedManager.getProductCartDataArray()
            }
        }
    }
}

struct ProductCartView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCartView()
    }
}
