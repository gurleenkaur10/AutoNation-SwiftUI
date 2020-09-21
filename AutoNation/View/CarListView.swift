//
//  CarListView.swift
//  AutoNation
//
//  Created by Gurleen Kaur on 2020-09-19.
//  Copyright © 2020 gurleen kaur. All rights reserved.
//

import SwiftUI

struct CarListView: View {
    @ObservedObject var networkManager = NetworkManager()
    let carList : CarList
    
    
    var body: some View {
        VStack {
            
            VStack(alignment: .center) {
                VStack(alignment: .leading){
                    Image(uiImage: networkManager.carImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading) {
                        Text("\(carList.year) " + carList.make + " " + carList.model)
                            .bold()
                        HStack {
                            Text("$\(carList.listPrice)").bold()
                            Text("I")
                            Text("\(carList.mileage) Mi")
                            Text("I")
                            Text(carLocation())
                        }
                    }
                }
                Button(action: {
                    
                    if let url = URL(string: "tel://\(self.carList.dealer.phone)"){
                        UIApplication.shared.canOpenURL(url)
                        UIApplication.shared.open(url, options: [:], completionHandler: nil) }
                    else {
                        return
                    }
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(carList.dealer.phone)
                    }
                }
            }
        } .onAppear {
            if let safeCarImage = self.carList.images.medium[0]{
                self.networkManager.fetchImage(url: safeCarImage)
            }
            
        }
    }
    // Private function to see which is the present owner and where the car is
    fileprivate func carLocation() -> String {
        var myCity = ""
        var myState = ""
        if carList.ownerHistory.history.count > 1{
            for history in carList.ownerHistory.history{
                if history.endOwnershipDate == "Present"{
                    if let safeCity = history.city{
                        myCity = safeCity + ", "
                    }
                    myState = history.state
                }
            }
        }
        else{
            if let safeCity = carList.ownerHistory.history[0].city{
                myCity = safeCity + ", "
            }
            myState = carList.ownerHistory.history[0].state
        }
        
        return myCity + myState
    }
    
    
    
}

