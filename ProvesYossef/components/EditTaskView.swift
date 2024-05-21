//
//  EditTaskView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 2/5/24.
//
//
//  EditTaskView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 2/5/24.
//
import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var editedTask: Task // Copia editada de la tarea
    
    private var originalTask: Task // Tarea original para referencia

    init(task: Task) {
        self.originalTask = task.returnCopy()
        _editedTask = ObservedObject(initialValue: task.returnCopy()) // Crear una copia de la tarea original
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("Título", text: $editedTask.title)
                }
                
                Section(header: Text("Descripción")) {
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
            }
            .navigationTitle("Editar Tarea")
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
        .onAppear {
            resetToOriginalTask()
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
        resetToOriginalTask()
        
        // Cerrar la vista de edición sin guardar cambios
        presentationMode.wrappedValue.dismiss()
    }
    
    private func resetToOriginalTask() {
        editedTask.setTask(originalTask)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(id: UUID(), title: "Sample Task", description: "This is a sample task description.", isCompleted: false)
        EditTaskView(task: sampleTask)
    }
}
