//
//  LocalData.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//

import Foundation

class LocalData: ObservableObject {
    static let shared = LocalData()
    @Published var pendingTasks: [Task] = []
    @Published var completedTasks: [Task] = []

    private let pendingTasksKey = "PendingTasks"
    private let completedTasksKey = "CompletedTasks"

    private init() {
        loadTasks()
    }

    func addTask(_ task: Task) {
        if task.isCompleted {
            completedTasks.append(task)
        } else {
            pendingTasks.append(task)
        }
        saveTasks()
    }

    func deleteTask(_ task: Task) {
        if let index = pendingTasks.firstIndex(where: { $0.id == task.id }) {
            pendingTasks.remove(at: index)
        } else if let index = completedTasks.firstIndex(where: { $0.id == task.id }) {
            completedTasks.remove(at: index)
        }
        saveTasks()
    }

    func toggleTaskCompletion(_ task: Task) {
        objectWillChange.send() // Notificar cambios manualmente
        if let index = pendingTasks.firstIndex(where: { $0.id == task.id }) {
            // Cambiar el estado de isCompleted de la tarea y moverla a la lista correspondiente
            pendingTasks[index].isCompleted = true
            let completedTask = pendingTasks.remove(at: index)
            completedTasks.append(completedTask)
        } else if let index = completedTasks.firstIndex(where: { $0.id == task.id }) {
            // Cambiar el estado de isCompleted de la tarea y moverla a la lista correspondiente
            completedTasks[index].isCompleted = false
            let pendingTask = completedTasks.remove(at: index)
            pendingTasks.append(pendingTask)
        }
        saveTasks()
    }

    func editTask(updatedTask: Task) {
        if let index = pendingTasks.firstIndex(where: { $0.id == updatedTask.id }) {
            pendingTasks[index] = updatedTask
        } else if let index = completedTasks.firstIndex(where: { $0.id == updatedTask.id }) {
            completedTasks[index] = updatedTask
        }
        saveTasks()
    }

    private func loadTasks() {
        if let pendingData = UserDefaults.standard.data(forKey: pendingTasksKey),
           let completedData = UserDefaults.standard.data(forKey: completedTasksKey) {
            let decoder = JSONDecoder()
            if let pendingTasks = try? decoder.decode([Task].self, from: pendingData) {
                self.pendingTasks = pendingTasks
            }
            if let completedTasks = try? decoder.decode([Task].self, from: completedData) {
                self.completedTasks = completedTasks
            }
        }
    }

    private func saveTasks() {
        let encoder = JSONEncoder()
        if let pendingTasksData = try? encoder.encode(pendingTasks) {
            UserDefaults.standard.set(pendingTasksData, forKey: pendingTasksKey)
        }
        if let completedTasksData = try? encoder.encode(completedTasks) {
            UserDefaults.standard.set(completedTasksData, forKey: completedTasksKey)
        }
    }
}
