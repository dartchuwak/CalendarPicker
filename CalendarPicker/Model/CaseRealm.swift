//
//  CaseRealm.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 22.03.2024.
//

import Foundation
import RealmSwift

class CaseRealm: Object {
    @Persisted var title: String
    @Persisted(primaryKey: true) var id: String

    convenience init(title: String, id: String) {
        self.init()
        self.title = title
        self.id = id
    }
}
