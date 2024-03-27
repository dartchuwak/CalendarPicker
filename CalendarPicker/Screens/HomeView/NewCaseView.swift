//
//  NewCaseView.swift
//  CalendarPicker
//
//  Created by Evgenii Mikhailov on 27.03.2024.
//

import SwiftUI

struct NewCaseView: View {
    @Environment(\.router) var router
    @EnvironmentObject var vm: HomeViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var color: Color = .purple
    var body: some View {
        VStack {
            Spacer().frame(height: 32)
            TextField("Title", text: $title)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(lineWidth: 1)
                }
                .padding(.horizontal)

            TextField("Description", text: $description)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15, style: .circular)
                        .stroke(lineWidth: 1)
                }
                .padding(.horizontal)

            ColorPicker(selection: $color, label: {
                Text("Pick up color")
            })
            .padding(.horizontal)
            Spacer()

            Button(action: {
                vm.addNewCase(title: title, desctiption: description, color: color)
                router.dismissScreen()
            }, label: {
                Text("Create a new case ")
            })

        }
        .toolbar {

        }
        .navigationTitle("Create a new case")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        NewCaseView()
    }
}
