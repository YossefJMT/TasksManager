//
//  EditTaskView.swift
//  ProvesYossef
//
//  Created by YossefJM on 2/5/24.
//

import Foundation
import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var editedTask: Task // Copia editada de la tarea
    @State private var subTaskDescription: String = "" // Nueva variable para la descripción de la subtarea

    private var originalTask: Task // Tarea original para referencia

    init(task: Task) {
        self.originalTask = task.returnCopy()
        _editedTask = ObservedObject(initialValue: task.returnCopy()) // Crear una copia de la tarea original
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tarea Principal")) {
                    TextField("Título", text: $editedTask.title)
                    TextField("Descripción", text: $editedTask.description)
                }
                Section {
                    HStack {
                        Text("Completado")
                        Spacer()
                        Button(action: {
                            editedTask.isCompleted.toggle()
                        }) {
                            Image(systemName: editedTask.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(editedTask.isCompleted ? .green : .gray)
                                .imageScale(.large)
                        }
                    }
                }
                
                Section(header: Text("Subtareas")) {
                    List {
                        ForEach(editedTask.subTasks.indices, id: \.self) { index in
                            HStack {
                                Button(action: {
                                    toggleSubTaskCompletion(at: index)
                                }) {
                                    Image(systemName: editedTask.subTasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(editedTask.subTasks[index].isCompleted ? .green : .gray)
                                        .imageScale(.large)
                                }
                                Text(editedTask.subTasks[index].description)
                            }
                        }
                        .onDelete(perform: removeSubTask)
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
            .navigationTitle("Editar Tarea")
            .navigationBarTitleDisplayMode(.inline) // Alinea el título en la parte superior
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Cancelar") {
                        cancelEditing() // Llamar a la función para cancelar la edición
                    }
                    .foregroundColor(.red)
                    .padding(30)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Guardar") {
                        saveTask() // Llamar a la función para guardar la tarea editada
                    }
                    .foregroundColor(.blue)
                    .padding(30)
                }
            }
        }
    }
    
    private func saveTask() {
        // Guardar los cambios en LocalData
        LocalData.shared.editTask(updatedTask: editedTask)
        
        // Cerrar la vista de edición
        presentationMode.wrappedValue.dismiss()
    }
    
    private func cancelEditing() {
        // Restaurar la tarea a su estado original
        editedTask.setTask(originalTask)
        
        // Cerrar la vista de edición sin guardar cambios
        presentationMode.wrappedValue.dismiss()
    }
    
    private func addSubTask() {
        guard !subTaskDescription.isEmpty else { return }
        let newSubTask = SubTask(description: subTaskDescription)
        editedTask.subTasks.append(newSubTask)
        subTaskDescription = ""
    }
    
    private func toggleSubTaskCompletion(at index: Int) {
        editedTask.subTasks[index].isCompleted.toggle()
    }
    
    private func removeSubTask(at indexSet: IndexSet) {
        editedTask.subTasks.remove(atOffsets: indexSet)
    }
}



struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(id: UUID(), title: "Sample Task", description: "This is a sample task description.", isCompleted: false, dateCreation: Date(), subTasks: [])
        EditTaskView(task: sampleTask)
    }
}
