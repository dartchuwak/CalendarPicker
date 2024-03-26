//
//  CalendarViewModel.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 13.03.2024.
//

import Foundation

final class CalendarViewModel: ObservableObject {

    @Published var dates = [Date]()
    let manager = DataBaseService.shared

    let calendar = Calendar.current

    func save(id: String) {
        manager.addDate(dates: dates, id: id)
    }

    func load(id: String) {
        let loadedDates = manager.getDateComponentsSet(id: id)
        self.dates = loadedDates
    }

    func getCurrentMonth()  -> Int{
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        return currentMonth
    }

    func filterByMonth() ->Int {
        let calendar = Calendar.current // Используем текущий календарь
        let monthToFilter = getCurrentMonth()
        let filteredDates = dates.filter { date in
            let month = calendar.component(.month, from: date) // Получаем месяц из даты
            return month == monthToFilter // Сравниваем с нужным месяцем
        }

        return filteredDates.count
    }

    func setupCalendar() {
        var calendar = Calendar.current // Получаем текущий календарь
        calendar.locale = Locale(identifier: "ru_RU") // Устанавливаем локаль, если нужно
        calendar.firstWeekday = 2
    }
}
