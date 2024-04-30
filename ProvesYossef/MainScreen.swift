        //
//  ContentView.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//
import SwiftUI

struct MainScreen: View {
    @State private var showingAddTaskView = false // Estado para controlar la presentación de la hoja modal
    @EnvironmentObject var localData: LocalData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(localData.tasks) { task in TaskCell(task: task)
                }
                .onDelete(perform: deleteTask) // Permitir eliminar tareas
            }
            .navigationTitle("Tareas")
            .navigationBarItems(
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
    
    func deleteTask(at offsets: IndexSet) {
        localData.tasks.remove(atOffsets: offsets) // Eliminar la tarea seleccionada
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
        return MainScreen().environmentObject(localData)
    }
}
