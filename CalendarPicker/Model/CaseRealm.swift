//
//  CaseRealm.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 22.03.2024.
//

import Foundation
import RealmSwift
import SwiftUI

class CaseRealm: Object {
    @Persisted var title: String = ""
    @Persisted var desc: String = ""
    @Persisted var color: String
    @Persisted(primaryKey: true) var id: String

    convenience init(title: String, id: String, description: String, color: UIColor) {
        self.init()
        self.title = title
        self.id = id
        self.desc = description
        let colorStr = color.asString
        self.color = colorStr
        print(color)
    }
}

import SwiftUI



