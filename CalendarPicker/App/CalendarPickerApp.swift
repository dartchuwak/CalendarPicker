//
//  CalendarPickerApp.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import RealmSwift
import SwiftUI
import SwiftfulRouting

@main
struct CalendarPickerApp: SwiftUI.App {
    @StateObject var mainViewModel = HomeViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()

    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                HomeView()
                    .preferredColorScheme(.light)
                    .accentColor(.black)
            }
            .environmentObject(mainViewModel)
            .environmentObject(calendarViewModel)
        }
    }
}
