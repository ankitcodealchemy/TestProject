//
//  ProductModelClass.swift
//  ShopingCart
//
//  Created by Code Alchemy on 4/6/22.
//

import Foundation

struct ProductModelClass : Identifiable, Decodable {
    
    var id      : Int
    var title   : String
    var price   : Double
    var description : String
    var category : String
    var image : String
    var rating : RatingModelClass
    
    struct RatingModelClass : Decodable {
        var rate : Double
        var count : Int
        
        init(){
            rate = 0
            count = 0
        }
        
        init(rate: Double, count: Int){
            self.rate = rate
            self.count = count
        }
    }
    
    init(){
        id = 0
        title = ""
        price = 0
        description = ""
        category = ""
        image = ""
        rating = RatingModelClass()
    }
    
    init(id: Int, title: String, price: Double, description: String, category: String, image: String, rating: RatingModelClass){
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}


class ProductCartModelClass : Identifiable {
    var id      : Int
    var title   : String
    var price   : Double
    var description : String
    var category : String
    var image : String
    var rate : Double
    var count : Int
    var productCartCount : Int
    
    init(){
        id = 0
        title = ""
        price = 0
        description = ""
        category = ""
        image = ""
        rate = 0
        count = 0
        productCartCount = 0
    }
    
    init(id: Int, title: String, price: Double, description: String, category: String, image: String, rate: Double, count: Int, productCartCount: Int){
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rate = rate
        self.count = count
        self.productCartCount = productCartCount
    }
    
    public class func decodeProductDataToCart(data : ProductModelClass) -> ProductCartModelClass {
        let obj         = ProductCartModelClass()
        obj.id          = data.id
        obj.title       = data.title
        obj.price       = data.price
        obj.description = data.description
        obj.category    = data.category
        obj.image       = data.image
        obj.rate        = data.rating.rate
        obj.count       = data.rating.count
        return obj
    }
    
    public class func decodeProductJSONToCart(dict : NSDictionary) -> ProductCartModelClass {
        let obj                 = ProductCartModelClass()
        obj.id                  = dict.value(forKey: "id") as? Int ?? 0
        obj.title               = dict.value(forKey: "title") as? String ?? ""
        obj.price               = dict.value(forKey: "price") as? Double ?? 0
        obj.description         = dict.value(forKey: "description") as? String ?? ""
        obj.category            = dict.value(forKey: "category") as? String ?? ""
        obj.image               = dict.value(forKey: "image") as? String ?? ""
        obj.rate                = dict.value(forKey: "rate") as? Double ?? 0
        obj.count               = dict.value(forKey: "count") as? Int ?? 0
        obj.productCartCount    = dict.value(forKey: "productCartCount") as? Int ?? 0
        return obj
    }
    
    public class func decodeProductJSONToCartArray(dataArray: NSArray) -> [ProductCartModelClass]{
        var objArray = [ProductCartModelClass]()
        for i in dataArray {
            let dict = i as! NSDictionary
            let obj = decodeProductJSONToCart(dict: dict)
            objArray.append(obj)
        }
        return objArray
    }
}

struct ProductCartRatingModelClass {
    var rate : Double
    var count : Int
    
    init(){
        rate = 0
        count = 0
    }
    
    init(rate: Double, count: Int){
        self.rate = rate
        self.count = count
    }
}

class ProductListApi : ObservableObject{
    @Published var productList = [ProductModelClass]()
    
    func loadProductList(completion:@escaping ([ProductModelClass]) -> ()) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                let products = try! JSONDecoder().decode([ProductModelClass].self, from: data!)
                print(products)
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    func loadProductDetail(product_id: Int,completion:@escaping (ProductModelClass) -> ()) {
        guard let url = URL(string: "https://fakestoreapi.com/products/\(product_id)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let product = try! JSONDecoder().decode(ProductModelClass.self, from: data!)
            print(product)
            DispatchQueue.main.async {
                completion(product)
            }
        }.resume()
    }
}
