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
                                NavigationLink {
                                    CalendarView(caseOb: caseObject, title: caseObject.title)
                                } label: {
                                    HStack {
                                        Text(caseObject.title)
                                        Spacer()
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(caseObject.color)
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
                        .listStyle(.sidebar)
                    }
                } else {
                    VStack {
                        Text("No cases yet...")
                            .font(.headline)
                        Text("Click button above to add a new case!")
                            .font(.subheadline)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                       // showingAlert.toggle()
                        createNewCase.toggle()
                        router.showScreen(.sheet) {
                            
                        } destination: { _ in
                            NewCaseView()
                        }
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        vm.wipeRealm()
                        vm.cases.removeAll()
                    }, label: {
                        Image(systemName: "trash.circle.fill")
                    })
                }
            }
            .onAppear {
                vm.loadCases()
            }
        }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
