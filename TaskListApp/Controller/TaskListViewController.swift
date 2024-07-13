//
//  TaskListViewController.swift
//  TaskListApp
//
//  Created by Sergey Zakurakin on 12/07/2024.
//

import UIKit




final class TaskListViewController: UITableViewController {
    
    
    private var taskList: [ToDoTask] = []
    private let cellId = "task"
    
    //MARK: - UI
    

    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    @objc private func addNewTask() {
        showAlert(withTitle: "New Task", andMassage: "What do you want to do")

        
    }
    
    private func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let fetchRequest = ToDoTask.fetchRequest()
        
        do {
            taskList = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    private func showAlert(withTitle title: String, andMassage massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save Task", style: .default) { [unowned self] _ in
            guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
            save(taskName)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "New Task"
        }
        present(alert, animated: true)
    }
    
    private func save(_ taskName: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let task = ToDoTask(context: appDelegate.persistentContainer.viewContext)
        task.title = taskName
        taskList.append(task)
        
        let indexPath = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        appDelegate.saveContext()
    }
    
}


//MARK: - setup TableViewDataSource
extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        // извлечение обекта
        let toDoTask = taskList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = toDoTask.title
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    
}





    //MARK: - Setup Navigation Bar
extension TaskListViewController {
    
    private func setupNavigationBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // navigation bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.backgroundColor = .milkBlue
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        
        // add button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    
}

