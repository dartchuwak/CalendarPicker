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
    @State var id = UUID()
    @State var date: Set<DateComponents> = []
    let caseOb: CaseObject
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            MultiDatePicker(anyDays: $vm.dates)
                .accentColor(caseOb.color)
Spacer()
            VStack(alignment: .leading) {
                Text("Total in current month: \(vm.filterByMonth())")
                Text("Total days picked: \(vm.dates.count)")
            }
            .padding(.horizontal)

        }
        .id(id)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    vm.save(id: caseOb.id)
                        dismis()
                }, label: {
                    Text("Save")
                })
            }
        }
        .onAppear {
            vm.setupCalendar()
            vm.load(id: caseOb.id)
            self.id = UUID()
        }
        .onDisappear {
            vm.save(id: caseOb.id)
        }
    }

    func simplifiedDateComponents(from components: DateComponents) -> DateComponents {
        return DateComponents(year: components.year, month: components.month, day: components.day)
    }
}

#Preview {
    NavigationStack {
        CalendarView(caseOb: CaseObject(id: "", title: "", description: "Описание", color: .cyan), title: "Прививка")
            .environmentObject(CalendarViewModel())
    }
}
