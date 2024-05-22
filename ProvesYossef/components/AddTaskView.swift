//
//  AddTaskView.swift
//  ProvesYossef
//
//  Created by YossefJM on 30/4/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var subTaskDescription: String = "" // Nueva variable para la descripción de la subtarea
    @State private var subTasks: [SubTask] = [] // Array para almacenar las subtareas
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tarea Principal")) {
                    TextField("Título", text: $title)
                    TextField("Descripción", text: $description)
                }
                
                Section(header: Text("Subtareas")) {
                    ForEach(subTasks) { subTask in
                        Text(subTask.description)
                    }
                    
                    HStack {
                        TextField("Nueva Subtarea", text: $subTaskDescription)
                        Button(action: addSubTask) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("button"))
                                .imageScale(.large)
                        }
                    }
                }
            }
            .navigationTitle("Agregar Tarea")
            .navigationBarItems(
                trailing: Button(action: {
                    // Guardar la nueva tarea y cerrar la hoja modal
                    let newTask = Task(title: title, description: description, isCompleted: false, subTasks: subTasks)
                    LocalData.shared.addTask(newTask)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add")
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color("button"))
                }
            )
        }
    }
    
    private func addSubTask() {
        guard !subTaskDescription.isEmpty else { return }
        let newSubTask = SubTask(description: subTaskDescription)
        subTasks.append(newSubTask)
        subTaskDescription = ""
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
