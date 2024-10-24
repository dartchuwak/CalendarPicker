//
//  DataBaseService.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import Foundation
import RealmSwift
import SwiftUI

final class DataBaseService {
    static let shared = DataBaseService()

    private init() {
        configRealm()
    }

    func saveCase(caseObject: CaseObject) {
        let realm = try! Realm()
        let caseObject = CaseRealm(title: caseObject.title, id: caseObject.id, description: caseObject.description, color: UIColor(caseObject.color))

        try! realm.write {
            realm.add(caseObject)
        }
    }

    func loadCases() -> [CaseObject] {
        do {

            let realm = try Realm()
            let objects = realm.objects(CaseRealm.self)
            let cases = objects.map {
                CaseObject(id: $0.id, title: $0.title, description: $0.desc, color: Color(uiColor: UIColor.from(string: $0.color) ?? .cyan))
            }
            return Array(cases)
        } catch {
            print (error.localizedDescription)
            return []
        }
    }

    func deleteItem(id: String) {
        do {
            let realm = try Realm()

            let object = realm.objects(CaseRealm.self).where({$0.id == id})
            let dates = realm.objects(DatesRealm.self).where({$0.id == id})
            try realm.write {
                realm.delete(object)
                realm.delete(dates)
            }

        } catch {
            print(error.localizedDescription)
        }

    }

    func wipeRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print("Ошибка при сбросе Realm: \(error)")
        }
    }

    func addDate(dates: [Date], id: String) {
        do {
            let realm = try Realm()
            try realm.write {
                if let existingObject = realm.objects(DatesRealm.self).filter({$0.id == id}).first {
                    realm.delete(existingObject)
                }

                let datesObject = DatesRealm(dates: dates, id: id)
                realm.add(datesObject)
            }
        } catch {
            print (error.localizedDescription)
        }
    }

    func getDateComponentsSet(id: String) -> [Date] {
        do {
            let realm = try Realm()
            guard let object = realm.objects(DatesRealm.self).first(where: { $0.id == id}) else { return [] }
            var dates: [Date] = []
            let list = object.dates
            for date in list {
                dates.append(date)
            }
            return dates
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func configRealm() {
        let config = Realm.Configuration(
            // Новая версия схемы должна быть больше предыдущей
            schemaVersion: 2,

            // Блок миграции, который будет вызван автоматически, когда версия схемы увеличится
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: "CaseObject") { oldObject, newObject in
                        newObject?["color"] = "1,1,1,1"
                        newObject?["desc"] = ""
                    }
                    // Ничего не делаем, Realm автоматически обнаружит новые или удалённые свойства
                    // и обновит схему самостоятельно
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}
