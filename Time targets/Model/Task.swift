//
//  Task.swift
//  Time targets
//
//  Created by mac on 09.10.2021.
//

import UIKit

//тип задачи
enum TaskPriority {
//    текущая
    case normal
//    важная
    case important
}

// состояние задачи
enum TaskStatus: Int {
//    запланированная
    case planned
//    завершенная
    case completed
}

// требования к типу, описывающему сущность "Задача"
protocol TaskProtocol {
//    название
    var title: String {get set}
//    тип
    var type: TaskPriority {get set}
//    статус
    var status: TaskStatus {get set}
}

// сущность "Задача"
struct Task: TaskProtocol {
    var title: String
    var type: TaskPriority
    var status: TaskStatus
}

// протокол, описывающий сущность "Хранилище задач"
protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

// сущность "Хранилище задач"
class TasksStorage: TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol] {
//        временная реализация, возвращающая тестовую коллекцию задач
        let testTasks: [TaskProtocol] = [
            Task(title: "Купить хлеб", type: .normal, status: .planned),
            Task(title: "Помыть кота", type: .important, status: .planned),
            Task(title: "Отдать долг Арнольду", type: .important, status: .completed),
            Task(title: "Купить новый пылесос", type: .normal, status: .completed),
            Task(title: "Подарить цветы супруге", type: .important, status: .planned),
            Task(title: "Позвонить родителям", type: .important, status: .planned)
        ]
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {}
}
