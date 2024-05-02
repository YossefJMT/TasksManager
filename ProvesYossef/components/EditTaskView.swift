//
//  EditTaskView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 2/5/24.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode // Para controlar la presentación del view
    @State private var editedTask: Task // Variable de estado para almacenar la tarea editada
    
    init(task: Task) {
        _editedTask = State(initialValue: task) // Inicializar la tarea editada con la tarea recibida
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
                
                Section() {
                    HStack {
                        Text("Completado")
                        Spacer()
                        Image(systemName: editedTask.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(editedTask.completed ? .green : .gray)
                            .imageScale(.large)
                    }
                }

            }
            .navigationTitle("Editar Tarea")
            .navigationBarItems(leading: EmptyView(), trailing: EmptyView()) // Limpiar los elementos de la barra de navegación
            
            // Colocar los botones en la parte inferior de la vista
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Cancelar") {
                            cancelEditing() // Llamar a la función para cancelar la edición
                        }
                        .foregroundColor(.red) // Cambiar el color del botón Cancelar
                        
                        Spacer()
                        
                        Button("Guardar") {
                            saveTask() // Llamar a la función para guardar la tarea editada
                        }
                        .foregroundColor(.blue) // Cambiar el color del botón Guardar
                    }
                    .padding() // Añadir un espacio alrededor de los botones
                }
            }
        }
    }
    
    private func saveTask() {
        // Lógica para guardar la tarea editada en LocalData
        LocalData.shared.saveTasks()
        
        // Después de guardar, cerrar la vista de edición
        presentationMode.wrappedValue.dismiss()
    }
    
    private func cancelEditing() {
        // Cerrar la vista de edición sin guardar cambios
        presentationMode.wrappedValue.dismiss()
    }
}


struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(title: "Sample Task", description: "This is a sample task description.", completed: false)
        EditTaskView(task: sampleTask)
    }
}
