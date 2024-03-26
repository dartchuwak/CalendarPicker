//
//  HomeView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: HomeViewModel
    @State private var showingAlert = false
    @State private var name = ""
    var body: some View {
        NavigationStack {
            VStack {
                if !vm.cases.isEmpty {
                    VStack {
                        List {
                            ForEach(vm.cases) { caseObject in
                                NavigationLink {
                                    CalendarView(caseOb: caseObject, title: caseObject.title)
                                } label: {
                                    Text(caseObject.title)
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
                        showingAlert.toggle()
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
            .alert("Enter your name", isPresented: $showingAlert) {
                TextField("Enter your name", text: $name)
                Button(action: {
                    vm.addNewCase(title: name)
                    self.name = ""
                }, label: {
                    Text("OK")
                })
                Button("Cancel", role: .cancel) {
                    showingAlert = false
                }
            }
            .onAppear {
                vm.loadCases()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
