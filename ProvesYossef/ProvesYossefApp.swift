//
//  ProvesYossefApp.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//

import SwiftUI

@main
struct ProvesYossefApp: App {
    @ObservedObject private var localData = LocalData.shared

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .environmentObject(localData) // Pasar localData como un entorno a MainScreen
        }
    }
}
