//
//  NewTaskViewController.swift
//  TaskListApp
//
//  Created by Sergey Zakurakin on 12/07/2024.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    weak var delegate: NewTaskViewControllerDelegate?
    
    //MARK: - UI
    private lazy var taskTextField: UITextField = {
       let element = UITextField()
        element.placeholder = "New Task"
        element.borderStyle = .roundedRect
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var saveButton: UIButton = {
        //set attribute for button title
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        // setup button with configuration
        var elementConfig = UIButton.Configuration.filled()
        elementConfig.attributedTitle = AttributedString("Save Task", attributes: attributes)
        elementConfig.baseBackgroundColor = .milkBlue
        
        
        
        let element = UIButton(configuration: elementConfig, primaryAction: UIAction {[unowned self] _ in
            
            save()
        })
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var cancelButton: UIButton = {
        //set attribute for button title
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        
        // setup button with configuration
        var elementConfig = UIButton.Configuration.filled()
        elementConfig.attributedTitle = AttributedString("Cancel", attributes: attributes)
        elementConfig.baseBackgroundColor = .milkRed
        
        let element = UIButton(configuration: elementConfig, primaryAction: UIAction {[unowned self] _ in
            dismiss(animated: true)
        })
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews(taskTextField, saveButton, cancelButton)
        setupConstraints()
    }
    
    private func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let task = ToDoTask(context: appDelegate.persistentContainer.viewContext)
        task.title = taskTextField.text
        appDelegate.saveContext()
        delegate?.reloadData()
        dismiss(animated: true)
    }
    
}


//MARK: - Setup View
private extension NewTaskViewController {
    
    func setupViews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
    }
}


//MARK: - Setup Constraint
private extension NewTaskViewController {
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
        
            taskTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
    
}






#Preview {
    NewTaskViewController()
}


