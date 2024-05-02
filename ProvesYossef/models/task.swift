//
//  task.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//

import Foundation
// Decodable significa que un tipo puede ser inicializado a partir de datos en formato JSON, permitiendo la decodificación de objetos desde una representación externa.
// Encodable es para que un tipo pueda ser convertido a una representación en formato JSON, permitiendo la codificación de objetos en una representación externa.
// Identifiable es un protocolo que indica que un tipo tiene una propiedad identificadora única, que es útil en vistas que requieren identificación de elementos en una lista, por ejemplo.


class Task: Identifiable, Decodable, Encodable { // Conformamos Task a Identifiable y Decodable
    var id: UUID
    var title: String
    var description: String
    var creationDate: Date
    var completed: Bool
    
    init(title: String, description: String, completed: Bool) {
        self.title = title
        self.description = description
        self.completed = completed
        self.creationDate = Date() // La fecha y hora de creación será la fecha actual
        self.id = UUID() // Generar un UUID único para cada instancia de Task

    }
}

