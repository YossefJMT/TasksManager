//
//  task.swift
//  ProvesYossef
//
//  Created by YossefJM on 29/4/24.
//

import Foundation

// Estructura para representar las subtareas
struct SubTask: Identifiable, Codable {
    var id: UUID = UUID()
    var description: String
    var isCompleted: Bool = false
}

class Task: Identifiable, ObservableObject, Codable {
    var id: UUID
    @Published var title: String
    @Published var description: String
    @Published var isCompleted: Bool
    var dateCreation: Date
    @Published var subTasks: [SubTask] // Array de subtareas
    
    init(title: String, description: String, isCompleted: Bool, dateCreation: Date = Date(), subTasks: [SubTask] = []) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.dateCreation = dateCreation
        self.subTasks = subTasks
    }
    
    init(id: UUID, title: String, description: String, isCompleted: Bool, dateCreation: Date, subTasks: [SubTask]) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.dateCreation = dateCreation
        self.subTasks = subTasks
    }

    func returnCopy() -> Task {
        return Task(id: self.id, title: self.title, description: self.description, isCompleted: self.isCompleted, dateCreation: self.dateCreation, subTasks: self.subTasks)
    }
    
    func setTask(_ task: Task) {
        self.id = task.id
        self.title = task.title
        self.description = task.description
        self.isCompleted = task.isCompleted
        self.dateCreation = task.dateCreation
        self.subTasks = task.subTasks
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description, isCompleted, dateCreation, subTasks
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        dateCreation = try container.decode(Date.self, forKey: .dateCreation)
        subTasks = try container.decode([SubTask].self, forKey: .subTasks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encode(dateCreation, forKey: .dateCreation)
        try container.encode(subTasks, forKey: .subTasks)
    }
}
