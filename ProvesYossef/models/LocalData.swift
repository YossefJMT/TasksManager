//
//  LocalData.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//

import SwiftUI

class LocalData: ObservableObject {
    static let shared = LocalData() // Singleton para acceder a la misma instancia en toda la aplicación

    @Published var tasks: [Task] = []

    public init() {
        // Inicialización privada para evitar la creación de instancias adicionales
        // Añadir una tarea por defecto
        let defaultTask = Task(title: "Tarea predeterminada", description: "Esta es una tarea predeterminada.", completed: false)
        tasks.append(defaultTask)
    }

    func addTask(title: String, description: String, completed: Bool) {
        let newTask = Task(title: title, description: description, completed: completed)
        tasks.append(newTask)
    }

    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
}
