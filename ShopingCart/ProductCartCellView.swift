//
//  ProductCartCellView.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCartCellView: View {
    
    var productData : ProductCartModelClass
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                if productData.image != "" {
                    WebImage(url: URL(string: productData.image))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding([.leading, .trailing], 5)
                }
                VStack(alignment: .leading,spacing:5){
                    Text(productData.title)
                        .font(.system(size: 18))
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Text(productData.description)
                        .font(.system(size: 14))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                    
                    
                    Text("$\(productData.price, specifier: "%.1f")")
                        .font(.system(size: 18))
                        .bold()
                        .frame(width: 80, height: 30)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Text("Product Count : \(productData.productCartCount)").font(.system(size: 18))
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5))
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding([.leading, .trailing], 10)
    }
}

struct ProductCartCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCartCellView(productData: ProductCartModelClass(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",rate: 2,count: 250,productCartCount: 2))
    }
}
