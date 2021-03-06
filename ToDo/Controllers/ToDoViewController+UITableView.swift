//
//  ToDoViewController+UITableView.swift
//  ToDo
//
//  Created by Shagara F Nasution on 26/06/20.
//  Copyright © 2020 Shagara F Nasution. All rights reserved.
//

import UIKit

//MARK: - TableView DataSource Methods

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let lengthOfToDoItems = toDoItems?.count, lengthOfToDoItems > 0 {
            return lengthOfToDoItems
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let items = toDoItems, items.count > 0 {
            let item = items[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
            
            cell.delegate = self
            
            cell.toDoTitle.text = item.title
            
            let dateFormatter = DateFormatter()
            
            let startDateTime = item.startDateTime
            let finishDateTime = item.finishDateTime
            
            dateFormatter.dateFormat = "E, d MMM yyyy"
            let stringMonth = dateFormatter.string(from: startDateTime)
            
            dateFormatter.timeStyle = DateFormatter.Style.short
            let stringStartTime = dateFormatter.string(from: startDateTime)
            let stringFinishTime = dateFormatter.string(from: finishDateTime)
            
            let stringTaskTime = "\(stringMonth), \(stringStartTime) - \(stringFinishTime)"
            cell.activityDate.text = stringTaskTime
            
            if !item.done {
                cell.toDoTitle.textColor = .label
                cell.activityDate.textColor = .label
            } else {
                cell.toDoTitle.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                cell.activityDate.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
            
            cell.toDoTitle.strikeThrough(item.done)
            cell.activityDate.strikeThrough(item.done)
            
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseEmptyToDoCell", for: indexPath) as! EmptyToDoCell
            return cell
        }
    }
}

//MARK: - TableView Delegate Methods

extension ToDoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = toDoItems {
            let item = items[indexPath.row]
            
            if !item.done {
                let formToDoVC = FormToDoViewController()
                
                formToDoVC.delegate = self
                formToDoVC.formToDoType = .update
                formToDoVC.toDoItem = item
                
                self.navigationController?.pushViewController(formToDoVC, animated: true)
            }
        }
    }
}

//MARK: - Entension String

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        
        return attributeString
    }
}

//MARK: - Entension UILabel

extension UILabel {
    func strikeThrough(_ isStrikeThrough:Bool) {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText {
                let txt = attributedStringText.string
                
                self.attributedText = nil
                self.text = txt
            }
        }
    }
}

