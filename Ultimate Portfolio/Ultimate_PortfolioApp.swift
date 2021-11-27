//
//  Ultimate_PortfolioApp.swift
//  Ultimate Portfolio
//
//  Created by Ionut Ciovica on 27/11/2021.
//

import SwiftUI

@main
struct Ultimate_PortfolioApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
