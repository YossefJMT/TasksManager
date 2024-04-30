//
//  AddTaskView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 30/4/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Título", text: $title)
                TextField("Descripción", text: $description)
            }
            .navigationTitle("Agregar Tarea")
            .navigationBarItems(
                trailing: Button(action: {
                    // Guardar la nueva tarea y cerrar la hoja modal
                    LocalData.shared.addTask(title: title, description: description, completed: false)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add")
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color("button"))
                }
            )
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
