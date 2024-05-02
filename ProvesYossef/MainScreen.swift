        //
//  ContentView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//
import SwiftUI

struct MainScreen: View {
    @State private var showingAddTaskView = false // Estado para controlar la presentación de la hoja modal
    @EnvironmentObject var localData: LocalData // Declaración de localData como un entorno
    
    @Environment(\.colorScheme) var colorScheme // Obtener el esquema de color actual
    
    var body: some View {
        NavigationView {
            List {
                ForEach(localData.tasks.indices, id: \.self) { index in
                    TaskCell(task: $localData.tasks[index])
                }
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
                trailing: Button(action: {
                    // Mostrar la hoja modal de "Agregar Tarea"
                    showingAddTaskView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill") // Icono de agregar
                        .foregroundColor(Color("button"))
                }
            )

        }
        .sheet(isPresented: $showingAddTaskView) {
            // Mostrar la hoja modal de "Agregar Tarea"
            AddTaskView()
        }
    }
    
    func deleteTasks(at offsets: IndexSet) {
        // Convertir el conjunto de índices a un array de índices
        let indexes = Array(offsets)
        // Iterar sobre los índices y eliminar las tareas correspondientes
        for index in indexes {
            localData.deleteTask(at: index)
        }
    }
}


struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Crear datos de muestra para las tareas
        let sampleTasks = [
            Task(title: "Tarea 1", description: "Descripción de la tarea 1", completed: false),
            Task(title: "Tarea 2", description: "Descripción de la tarea 2", completed: true),
            Task(title: "Tarea 3", description: "Descripción de la tarea 3", completed: false)
        ]
        
        // Crear una instancia de LocalData con los datos de muestra
        let localData = LocalData()
        localData.tasks = sampleTasks
        
        // Crear una instancia de MainScreen y pasar LocalData como entorno
        return MainScreen()
            .environmentObject(localData)
    }
}

