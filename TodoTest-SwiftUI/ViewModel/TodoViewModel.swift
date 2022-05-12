//
//  TodoViewModel.swift
//  TodoTest-SwiftUI
//
//  Created by James Christian Wira on 13/05/22.
//

import Foundation
import CoreData

class TodoViewModel: ObservableObject {
    // MARK: Edittable field
    @Published var title: String = ""
    @Published var content: String = ""
    
    // MARK: Object used in AddTodoSheet
    // If editItem has no data, then AddTodoSheet is used to add new todo
    // If editItem has data, then AddTodoSheet is used to edit existing todo
    @Published var editItem: TodoItem?
    
    func addTodo() {
        // TODO: For sharing session
    }
    
    // Reset existing data when closing sheet
    func resetData() {
        title = ""
        content = ""
    }
    
    // Setting up editItem for the sheet
    func setupEditItem() {
        if let editItem = editItem {
            title = editItem.title ?? ""
            content = editItem.content ?? ""
        }
    }
}
