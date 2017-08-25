//
//  ShopController.swift
//  CafeNomad
//
//  Created by Vince Lee on 2017/8/25.
//  Copyright © 2017年 Vince Lee. All rights reserved.
//

import Foundation
import UIKit

class ShopController {
    
    static let shared = ShopController()
    
    func fetchShop(completion: @escaping ([Shop]?) -> Void) {
        let urlStr = "https://cafenomad.tw/api/v1.2/cafes/taipei"
        let url = URL(string: urlStr)
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
          let decoder = JSONDecoder()
            let shop1 = try? decoder.decode([Shop].self, from: data!)
            print(data)
            print(shop1)
            if let data = data, let shop = try? decoder.decode([Shop].self, from: data) {
                
                completion(shop)
          
                
                
            } else {
                completion(nil)
            }
        }
    
        task.resume()
      
        
        
    }
        
        
    }
    
    



