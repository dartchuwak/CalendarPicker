//
//  HomeViewModel.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var cases: [CaseObject] = []

    func addNewCase(title: String, desctiption: String, color: Color) {
        let newCase = CaseObject(id: UUID().uuidString, title: title, description: "", color: color)
        cases.append(newCase)
        saveCase(caseObject: newCase)
    }

    func loadCases() {
        let cases =  DataBaseService.shared.loadCases()
        self.cases = cases
    }

    func saveCase(caseObject: CaseObject) {
        DataBaseService.shared.saveCase(caseObject: caseObject)
    }

    func deleteItem(id: String) {
        DataBaseService.shared.deleteItem(id: id)
        cases.removeAll(where: {$0.id == id})
    }

    func wipeRealm() {
        DataBaseService.shared.wipeRealm()
    }
}
