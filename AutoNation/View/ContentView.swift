//
//  ContentView.swift
//  AutoNation
//
//  Created by Gurleen Kaur on 2020-09-18.
//  Copyright © 2020 gurleen kaur. All rights reserved.
//

import SwiftUI

/*
List view uses the result got from network call and creates CarListView for each entry
CarListView is a struct that define each block in the list
takes Struct CarList as an input
 */

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        
        NavigationView{
            List(networkManager.resultList) { car in
                CarListView(carList: car)
                }
            .onAppear {
                self.networkManager.fetchData()
                }
            .navigationBarTitle("AutoNation")
            .background(Color.pink)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
