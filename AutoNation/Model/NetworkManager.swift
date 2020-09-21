//
//  NetworkManager.swift
//  AutoNation
//
//  Created by Gurleen Kaur on 2020-09-19.
//  Copyright © 2020 gurleen kaur. All rights reserved.
//

import UIKit


class NetworkManager: ObservableObject {
    @Published var resultList = [CarList]()
    @Published var carImage = UIImage()
    
    //network call to fetch all the data
    func fetchData(){
        
        if let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do {
                            let results = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                self.resultList = results.listings
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    //Network call to fetch images of car for the list
    //input needed: Image URL
    func fetchImage(url: String) {
        
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    if let safeData = data{
                        if let image = UIImage(data: safeData){
                            DispatchQueue.main.async {
                                self.carImage = image
                            }
                            
                        }
                    }
                    
                }
            }
            task.resume()
        }
        
        
    }
}
