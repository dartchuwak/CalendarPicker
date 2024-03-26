//
//  CalendarPickerApp.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import SwiftUI

@main
struct CalendarPickerApp: App {

    @StateObject var mainViewModel = HomeViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()


    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(mainViewModel)
                .environmentObject(calendarViewModel)
        }
    }
}
