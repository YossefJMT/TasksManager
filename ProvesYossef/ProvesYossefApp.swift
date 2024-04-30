//
//  ProvesYossefApp.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//

import SwiftUI

@main
struct ProvesYossefApp: App {
    
    @StateObject private var localData = LocalData.shared

        var body: some Scene {
            WindowGroup {
                MainScreen().environmentObject(localData)
            }
        }
}
