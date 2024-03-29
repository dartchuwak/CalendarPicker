//
//  CalendarPickerApp.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import SwiftUI
import SwiftfulRouting

@main
struct CalendarPickerApp: App {

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
            .onAppear {
                DataBaseService.shared.realmMigration()
                print(getVersionNumber())
            }
        }
    }

    func getVersionNumber() -> String {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
        return appVersion
    }
}
