//
//  SettingsView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 27.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct SettingsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.router) var router
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "doc.append")
                    Link("Privacy Policy", destination: URL(string: "https://eventmark-9700a.web.app/privacy.html")!)
                        .foregroundStyle(Color.black)
                }
            } header: {
                Text("Legal")
            }


            Section {
                HStack {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("Reset all data")
                }
                .onTapGesture {
                    router.showAlert(.alert, title: "Are you sure?", subtitle: "All the saved data will be lost") {
                        Button("Reset", role: .destructive) {
                            homeViewModel.wipeRealm()
                            homeViewModel.cases.removeAll()
                        }
                    }
                }
            } header: {
                Text("Reset")
            }
        }
        .navigationTitle("Settings & Legal")
    }
}

//vm.wipeRealm()
//vm.cases.removeAll()

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(HomeViewModel())
    }
}
