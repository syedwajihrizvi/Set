//
//  SetApp.swift
//  Set
//
//  Created by Wajih Rizvi on 2022-08-27.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
