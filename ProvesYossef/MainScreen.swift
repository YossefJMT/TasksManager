    //
//  ContentView.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//

import SwiftUI

struct MainScreen: View {
    @State private var showingAddTaskView = false // Estado para controlar la presentación de la hoja modal
    @EnvironmentObject var localData: LocalData // Declaración de localData como un entorno
    @State private var showingCompletedTasks = false // Estado para controlar la visualización de las tareas completadas

    @Environment(\.colorScheme) var colorScheme // Obtener el esquema de color actual
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    showingCompletedTasks.toggle()
                }) {
                    Text(showingCompletedTasks ? "Ocultar Completadas" : "Ver Completadas")
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                        
                }
                ForEach(tasksToShow) { task in TaskCell(task: task)}
                    .onDelete(perform: deleteTasks) // Permitir eliminar tareas

            }
            .navigationTitle("Tareas")
            .navigationBarItems(
                leading: Button(action: {
                    // Cambiar el esquema de color cuando se presiona el botón
                    if #available(iOS 13.0, *) {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            windowScene.windows.first?.overrideUserInterfaceStyle = colorScheme == .dark ? .light : .dark
                        }
                    } else {
                        if let window = UIApplication.shared.windows.first {
                            window.overrideUserInterfaceStyle = colorScheme == .dark ? .light : .dark
                        }
                    }
                }) {
                    Image(systemName: "moon.circle.fill") // Icono de modo oscuro
                        .foregroundColor(.primary) // Color primario del texto
                },
                trailing: HStack {
                    Button(action: {
                        showingAddTaskView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill") // Icono de agregar
                            .foregroundColor(Color("button"))
                    }
                }
            )

        }
        .sheet(isPresented: $showingAddTaskView) {
            // Mostrar la hoja modal de "Agregar Tarea"
            AddTaskView()
        }
    }
    
    private var tasksToShow: [Task] {
        if showingCompletedTasks {

            return localData.completedTasks
        } else {

            return localData.pendingTasks
        }
    }
    
    func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let taskToDelete = tasksToShow[index]
            localData.deleteTask(taskToDelete)
        }
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Crear datos de muestra para las tareas
        let samplePendingTasks = [
            Task(title: "Tarea 1", description: "Descripción de la tarea 1", isCompleted: false),
            Task(title: "Tarea 2", description: "Descripción de la tarea 2", isCompleted: false),
            Task(title: "Tarea 3", description: "Descripción de la tarea 3", isCompleted: false)
        ]
        
        let sampleCompletedTasks = [
            Task(title: "Tarea 4", description: "Descripción de la tarea 4", isCompleted: true),
            Task(title: "Tarea 5", description: "Descripción de la tarea 5", isCompleted: true)
        ]

        // Crear una instancia de LocalData con los datos de muestra
        let localData = LocalData.shared
        localData.pendingTasks = samplePendingTasks
        localData.completedTasks = sampleCompletedTasks
        
        // Crear una instancia de MainScreen y pasar LocalData como entorno
        return MainScreen()
            .environmentObject(localData)
    }
}
