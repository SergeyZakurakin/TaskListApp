//
//  TaskListViewController.swift
//  TaskListApp
//
//  Created by Sergey Zakurakin on 12/07/2024.
//

import UIKit

protocol NewTaskViewControllerDelegate: AnyObject {
    func reloadData()
}


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
        // метод пирехода экрана
        let newTaskVC = NewTaskViewController()
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
        
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

extension TaskListViewController: NewTaskViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
    
}
