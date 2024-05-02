//
//  LocalData.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//

import SwiftUI

class LocalData: ObservableObject {
    // Singleton para acceder a la misma instancia en toda la aplicación
    static let shared = LocalData()

    @Published var tasks: [Task] = []

    private let tasksKey = "tasks"

    public init() {
        // Cargar tareas guardadas desde UserDefaults
        if let savedTasksData = UserDefaults.standard.data(forKey: tasksKey) {
            if let decodedTasks = try? JSONDecoder().decode([Task].self, from: savedTasksData) {
                tasks = decodedTasks
                return
            }
        }
        // Si no hay datos guardados, añadir una tarea por defecto
        let defaultTask = Task(title: "Tarea predeterminada", description: "Esta es una tarea predeterminada.", completed: false)
        tasks.append(defaultTask)
    }

    func saveTasks() {
        // Guardar las tareas en UserDefaults
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: tasksKey)
        }
    }

    func addTask(title: String, description: String, completed: Bool) {
        let newTask = Task(title: title, description: description, completed: completed)
        tasks.append(newTask)
        saveTasks() // Guardar las tareas actualizadas
    }

    func deleteTask(at index: Int) {
        // Imprimir la tarea antes de eliminarla en la consola
        print("Tarea a eliminar:", tasks[index].title)
        
        tasks.remove(at: index)
        saveTasks() // Guardar las tareas actualizadas
    }
    
    func editTask(task: Task) {
        print("Tarea editada:", task.title, task.description, task.id )
        print("Tarea a editar:", tasks[1].title, tasks[1].description, tasks[1].id )

        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            print("Tarea a editar:", tasks[index].title, tasks[index].description, tasks[index].id )

            tasks[index] = task // Reemplazar la tarea original con la tarea editada
            saveTasks() // Guardar las tareas actualizadas
        }
    }


}


