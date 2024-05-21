//
//  task.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//

import Foundation

class Task: Identifiable, ObservableObject, Codable {
    let id: UUID
    @Published var title: String
    @Published var description: String
    @Published var isCompleted: Bool
    
    init(title: String, description: String, isCompleted: Bool) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
    init(id: UUID, title: String, description: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
    
    // Función para devolver una copia de la tarea
    func returnCopy() -> Task {
        return Task(id: self.id, title: self.title, description: self.description, isCompleted: self.isCompleted)
    }
    
    func setTask(_ task: Task) {
            self.title = task.title
            self.description = task.description
            self.isCompleted = task.isCompleted
        }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, isCompleted
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(isCompleted, forKey: .isCompleted)
    }
}

