//
//  TaskEditController.swift
//  Time targets
//
//  Created by mac on 19.10.2021.
//

import UIKit

class TaskEditController: UITableViewController {
    
//    параметры задачи
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
//    текстовое поле с названием задачи
    @IBOutlet var taskTitle: UITextField!
    
//    выбранная задача
    @IBOutlet var taskTypeLabel: UILabel!
    
//    переключатель статуса
    @IBOutlet var taskStatusSwitch: UISwitch!

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
//        получаем актуальное значение
        let title = taskTitle?.text ?? ""
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
//        вызываем обработчик
        doAfterEdit?(title, type, status)
//        возвращаемся к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        обновление текстового поля с названием задачи
        taskTitle?.text = taskText
        
//        обновление метки в соответствии с текущим типом
        taskTypeLabel?.text = taskTitles[taskType]
        
//        обновляем статус задачи
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }
    
//    название типов задач
    private var taskTitles: [TaskPriority: String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
//            ссылка на контроллер назначения
            let destination = segue.destination as! TaskTypeController
//            передача выбранного типа
            destination.selectedType = taskType
//            передача обработчика выбора типа
            destination.doAfterTypeSelected = { [unowned self] selectedType in
                taskType = selectedType
//                обновляем метку с текущим типом
                taskTypeLabel?.text = taskTitles[taskType]
            }
        }
    }

}
