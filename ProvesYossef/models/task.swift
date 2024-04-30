//
//  task.swift
//  ProvesYossef
//
//  Created by Novostorm7 on 29/4/24.
//

import Foundation

class Task: Identifiable { // Conformamos Task a Identifiable
    let id = UUID() // Propiedad id de tipo UUID
    let title: String
    let description: String
    let creationDate: Date
    let completed: Bool
    
    init(title: String, description: String, completed: Bool) {
        self.title = title
        self.description = description
        self.completed = completed
        self.creationDate = Date() // La fecha y hora de creación será la fecha actual
    }
}

