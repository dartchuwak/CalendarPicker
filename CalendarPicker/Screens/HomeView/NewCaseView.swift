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
    @Environment(\.colorScheme) var scheme
    @State private var title = ""
    @State private var description = ""
    @State private var selectedColor: Color = .purple

    private let colors: [Color] = [
        .red,
        .brown,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .purple,
        .indigo
    ]

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
            Text("Pick color")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    Spacer(minLength: 16)
                    ForEach(colors, id: \.self) { color in
                        VStack {
                            if selectedColor == color {
                                Spacer().frame(height: 16)
                            }
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(color)

                            if selectedColor == color {
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(color)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                selectedColor = color
                            }

                        }

                    }
                }
            }
            Spacer()
            Button(action: {
                vm.addNewCase(title: title, desctiption: description, color: selectedColor)
                router.dismissScreen()
            }, label: {
                Text("Create a new case ")
                    .foregroundStyle(scheme == .dark ? .black : .white)
                    .padding()
                    .background(scheme == .dark ? .white : .black)
                    .cornerRadius(15)

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
