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
    var body: some View {
            VStack {
                if !vm.cases.isEmpty {
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 32)
                            ForEach(vm.cases) { caseObject in
                                    HStack {
                                        Text(caseObject.title)
                                        Spacer()
                                        Button(action: {
                                            let caseId = caseObject.id
                                            vm.deleteItem(id: caseId)
                                        }, label: {
                                            Image(systemName: "trash.circle")
                                                .resizable()
                                                .frame(width: 24, height: 24)

                                        })
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(caseObject.color)
                                    .cornerRadius(15)
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
                        .padding(.horizontal)

                    }
                } else {
                    VStack {
                        Text("No events to track yet...")
                            .font(.title)
                        Text("Click the button above to add a new event!")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
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
            .preferredColorScheme(.light)
    }
}
