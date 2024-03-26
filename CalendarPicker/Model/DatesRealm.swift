//
//  DateComponentObject.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 14.03.2024.
//

import Foundation
import RealmSwift


class DatesRealm: Object {
    @Persisted var id: String
    @Persisted var dates: RealmSwift.List<Date>

    convenience init(dates: [Date], id: String) {
        self.init()
        self.id = id
        for date in dates {
                self.dates.append(date)
            }
        }
    }
