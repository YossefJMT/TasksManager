//
//  TaskCell.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//


import SwiftUI
struct TaskCell: View {
    var task: Task

    var body: some View {
        NavigationLink(destination: EditTaskView(task: task)) {
            HStack(alignment: .center, spacing: 12) {
                Button(action: {
                    toggleCompleted()
                }) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? .green : .gray)
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle()) // No es necesario con PlainButtonStyle() porque el Button ya lo tiene

                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(task.isCompleted ? .gray : Color("headings"))
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
    }

    private func toggleCompleted() {
        withAnimation {
            task.isCompleted.toggle() // Cambiar el estado de completitud de la tarea
            LocalData.shared.toggleTaskCompletion(task) // Al hacer clic, actualizamos el estado en LocalData directamente
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTask = Task(title: "Sample Task", description: "This is a sample task description.", isCompleted: false)
        return TaskCell(task: sampleTask)
    }
}
