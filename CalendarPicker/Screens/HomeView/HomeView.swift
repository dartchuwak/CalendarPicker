//
//  HomeView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import SwiftUI
import SwiftfulRouting

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @Environment(\.router) var router
    @Environment(\.colorScheme) var scheme
    @State private var showingAlert = false
    @State private var createNewCase = false
    @State private var name = ""
    @State private var color: Color = .red
    var body: some View {
            VStack {
                if !vm.cases.isEmpty {
                    VStack {
                        List {
                            ForEach(vm.cases) { caseObject in
                                    HStack {
                                        Text(caseObject.title)
                                        Spacer()
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(caseObject.color)
                                    }
                                    .onTapGesture {
                                        router.showScreen(.push) { _ in
                                            CalendarView(caseOb: caseObject, title: caseObject.title)
                                        }
                                    }
                            }
                            .onDelete(perform: { indexSet in
                                indexSet.forEach { index in
                                        let caseId = vm.cases[index].id
                                        vm.deleteItem(id: caseId)
                                    }
                            })
                        }
                        .listStyle(.insetGrouped)
                    }
                } else {
                    VStack {
                        Text("No cases yet...")
                            .font(.title)
                        Text("Click button above to add a new case!")
                            .font(.subheadline)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        router.showScreen(.sheet) {

                        } destination: { _ in
                            NewCaseView()
                        }
                    }, label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(scheme == .light ? .black : .white )
                    })
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        router.showScreen(.push) { _ in
                            SettingsView()
                        }
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(scheme == .light ? .black : .white )
                    })
                }
            }
            .onAppear {
                vm.loadCases()
            }
        }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
