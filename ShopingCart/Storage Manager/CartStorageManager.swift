//
//  CartStorageManager.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import Foundation

var KEY_PRODUCT_CART_DATA = "KEY_PRODUCT_CART_DATA"
var userDefault = UserDefaults.standard

class CartStorageManager : NSObject {
    
    static let sharedManager = CartStorageManager()
    
    func saveProductData(productData: ProductModelClass){
        let productDataDecoded = ProductCartModelClass.decodeProductDataToCart(data: productData)
        if let productCartData = (userDefault.value(forKey: KEY_PRODUCT_CART_DATA) as? String){
            var isProductFound = false
            
            if !productCartData.isEmpty{
                do{
                    var cartProductArray = ProductCartModelClass.decodeProductJSONToCartArray(dataArray: (try! JSONSerializer.toArray(productCartData )))
                    
                    for obj in cartProductArray{
                        if obj.id == productDataDecoded.id{
                            isProductFound = true
                            obj.productCartCount += 1
                            break
                        }
                    }
                    
                    if !isProductFound{
                        productDataDecoded.productCartCount = 1
                        cartProductArray.append(productDataDecoded)
                    }
                    
                    let jsonData = JSONSerializer.toJson(cartProductArray)
                    userDefault.setValue(jsonData, forKey: KEY_PRODUCT_CART_DATA)
                }
            } else {
                self.saveFirstProduct(productData: productDataDecoded)
            }
        } else {
            self.saveFirstProduct(productData: productDataDecoded)
        }
    }
    
    func saveFirstProduct(productData: ProductCartModelClass) {
        productData.productCartCount = 1
        let jsonData = JSONSerializer.toJson([productData])
        userDefault.setValue(jsonData, forKey: KEY_PRODUCT_CART_DATA)
    }
    
    func getProductCartDataArray() -> [ProductCartModelClass] {
        if let productCartData = (userDefault.value(forKey: KEY_PRODUCT_CART_DATA) as? String){
            if !productCartData.isEmpty{
                let productCartArray = ProductCartModelClass.decodeProductJSONToCartArray(dataArray: (try! JSONSerializer.toArray(productCartData)))
                return productCartArray
            } else {
                return [ProductCartModelClass]()
            }
        } else {
            return [ProductCartModelClass]()
        }
    }
    
    func getCartProductTotalCount() -> Int {
        var totalCartProduct = 0
        if let productCartData = userDefault.value(forKey: KEY_PRODUCT_CART_DATA){
            let cartProductArray = ProductCartModelClass.decodeProductJSONToCartArray(dataArray: (try! JSONSerializer.toArray(productCartData as! String)))
            for obj in cartProductArray {
                totalCartProduct += obj.productCartCount
            }
            return totalCartProduct
        } else{
            return 0
        }
    }
}
