//
//  ProductDetailView.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var productData = ProductModelClass()
    @State var product_id : Int
    @State var addedCartCount : Int = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                HStack(spacing:0) {
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
                    Text("Product Details")
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
                    if productData.id != 0 {
                        ScrollView{
                            VStack(spacing:0){
                                WebImage(url: URL(string: productData.image))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                                    .clipped()
                                VStack(alignment:.leading,spacing:20){
                                    Text(productData.title)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                    HStack(spacing:0){
                                        Text("$\(productData.price, specifier: "%.1f")")
                                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.blue)
                                            .cornerRadius(10)
                                        StarsView(rating: Float(productData.rating.rate))
                                            .padding(.leading)
                                        Text("(\(productData.rating.count))")
                                            .font(.system(size: 18))
                                            .bold()
                                            .foregroundColor(.orange)
                                            .padding(.leading, 10)
                                        Spacer()
                                    }
                                    Text(productData.description)
                                        .font(.system(size: 16, weight: .regular, design: .rounded))
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                }
                                .padding(20)
                            }
                        }
                        VStack(spacing:0){
                            Button {
                                CartStorageManager.sharedManager.saveProductData(productData: self.productData)
                                addedCartCount = CartStorageManager.sharedManager.getCartProductTotalCount()
                            } label: {
                                Text("Add to Cart")
                                    .frame(width: UIScreen.main.bounds.width-80, height: 30)
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.blue)
                                    .cornerRadius(10)
                            }
                        }
                    } else {
                        Spacer()
                        Text("Load Product Details")
                            .bold()
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                ProductListApi().loadProductDetail(product_id: product_id) { productDetailData in
                    productData = productDetailData
                }
                addedCartCount = CartStorageManager.sharedManager.getCartProductTotalCount()
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product_id: 1)
    }
}
