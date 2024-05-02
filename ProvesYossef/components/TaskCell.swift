//
//  TaskCell.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//


import SwiftUI

struct TaskCell: View {
    @Binding var task: Task // Usamos un Binding<Task> para que los cambios se reflejen automáticamente
    
    var body: some View {
        NavigationLink(destination: EditTaskView(task: task)) { // Pasamos $task para que se pueda editar
            HStack(alignment: .center, spacing: 12) {
                Button(action: {
                    toggleCompleted() // Llamamos a toggleCompleted para cambiar el estado de la tarea
                }) {
                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.completed ? .green : .gray)
                        .imageScale(.large)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(task.completed ? .gray : Color("headings"))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(Color("description"))
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
            }
            .padding(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func toggleCompleted() {
        task.completed.toggle() // Cambiamos directamente la propiedad completed de la tarea
        LocalData.shared.saveTasks() // Guardamos los cambios
    }
}


struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(title: "Sample Task", description: "This is a sample task description.", completed: false)
        // Creamos un Binding<Task> con la tarea de muestra
        let binding = Binding<Task>(get: { sampleTask }, set: { _ in })
        return TaskCell(task: binding)
    }
}

