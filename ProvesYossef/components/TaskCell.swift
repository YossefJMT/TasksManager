//
//  TaskCell.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//


import SwiftUI

struct TaskCell: View {
    @State private var isCompleted: Bool
    let task: Task
    
    init(task: Task) {
        self.task = task
        _isCompleted = State(initialValue: task.completed)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                isCompleted.toggle() // Alternar el estado del checkbox al hacer clic
                // Aquí podrías agregar lógica adicional para actualizar el estado de la tarea en tu modelo de datos
            }) {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : .gray) // Cambiar el color del checkbox según el estado de completado
                
                    .imageScale(.large) // Escalar el icono
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(isCompleted ? .gray : Color("headings")) // Cambiar el color del texto si está completado
                    .strikethrough (isCompleted) // Agregar tachado al texto si está completado

                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(Color("description"))
                    .strikethrough(isCompleted) // Agregar tachado al texto si está completado

            }
        }
        .padding(8)
        
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(title: "Sample Task", description: "This is a sample task description.", completed: false)
        return TaskCell(task: sampleTask)
    }
}


