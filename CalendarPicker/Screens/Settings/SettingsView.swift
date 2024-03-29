//
//  SettingsView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 27.03.2024.
//

import SwiftUI
import SwiftfulRouting
import  StoreKit

struct SettingsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.router) var router
    var body: some View {
        List {

            Section {
                HStack {
                    Image(systemName: "star")
                    Text("Rate app")
                }
                .onTapGesture {
                    rateApp()
                }
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
                Text("APP")
            } footer: {
                Text("App Version : \(getVersionNumber())")
            }

            Section {
                HStack {
                    Image(systemName: "doc.append")
                    Link("Privacy Policy", destination: URL(string: "https://eventmark-9700a.web.app/privacy.html")!)
                        .foregroundStyle(Color.black)
                }
            } header: {
                Text("Legal")
            }
        }
        .navigationTitle("Settings & Legal")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.dismissScreen()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                })
            }
        })
        .navigationBarBackButtonHidden()
    }


    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    func getVersionNumber() -> String {
        guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
        return appVersion
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(HomeViewModel())
    }
}
