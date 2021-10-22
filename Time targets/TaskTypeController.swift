//
//  TaskTypeController.swift
//  Time targets
//
//  Created by mac on 20.10.2021.
//

import UIKit

class TaskTypeController: UITableViewController {
    
//    1. кортеж, описывающий тип задачи
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
//    2. коллекция доступных типов задач с из описанием
    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")
    ]
    
//    3. выбранный приоритет
    var selectedType: TaskPriority = .normal
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        1. получение значения типа UINib, соответствующее xib-файлу кастомной ячейки
        let cellTypeNib = UINib(nibName: "TaskTypeCell", bundle: nil)
//        2. регистрация кастомной ячейки в табличном представлении
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TaskTypeCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        1. получение переиспользуемой кастомной ячейки по ее идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        
//        2. получаем текущий, информация о котором должна быть выведена в строке
        let typeDescription = taskTypesInformation[indexPath.row]
        
//        3. заполняем ячейку данными
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
//        4. если тип является выбранным, то отмечаем галочкой
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
//            в ином случае снимаем отметку
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskTypesInformation.count
    }
    
//    обработчик выбора типа
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        получаем выбранный тип
        let selectedType = taskTypesInformation[indexPath.row].type
//        вызов обработчика
        doAfterTypeSelected?(selectedType)
//        переход к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }

}
