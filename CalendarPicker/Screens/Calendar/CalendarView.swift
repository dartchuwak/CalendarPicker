//
//  CalendarView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import SwiftUI
import RealmSwift
import MultiDatePicker

struct CalendarView: View {

    @EnvironmentObject var vm: CalendarViewModel
    @Environment(\.dismiss) var dismis
    @Environment(\.router) var router
    @State var id = UUID()
    let caseOb: CaseObject
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(caseOb.description)
                .padding(.horizontal)
                .foregroundColor(.gray)
            MultiDatePicker(anyDays: $vm.dates)
                .accentColor(caseOb.color)
            Spacer()
        }
        .id(id)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.save(id: caseOb.id)
                    router.dismissScreen()
                }, label: {
                    Text("Save")
                        .tint(.black)
                })
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.dismissScreen()
                }, label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                })
            }
        }
        .onAppear {
            vm.setupCalendar()
            vm.load(id: caseOb.id)
            self.id = UUID()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        CalendarView(caseOb: CaseObject(id: "", title: "", description: "Описание события", color: .cyan), title: "Прививка")
            .environmentObject(CalendarViewModel())
    }
}
