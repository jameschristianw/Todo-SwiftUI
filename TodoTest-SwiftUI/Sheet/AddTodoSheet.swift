//
//  AddTodoSheet.swift
//  TodoTest-SwiftUI
//
//  Created by James Christian Wira on 13/05/22.
//

import SwiftUI

struct AddTodoSheet: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var title: String = ""
    @State var contentDetail: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Title")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $title)
                    Divider()
                    Text("Todo Detail")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $contentDetail)
                        .frame(height: 100)
                        .multilineTextAlignment(.leading)
                    Divider()
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            }
            .padding()
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button  {
                        // TODO: Change logic to use ViewModel to save newTodo
                        
                        let newTodo = TodoItem(context: moc)
                        
                        newTodo.title = self.title
                        newTodo.content = self.contentDetail
                        newTodo.isFinished = false
                        
                        try? moc.save()
                        
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(title.isEmpty)
                    .opacity(title.isEmpty ? 0.6 : 1)
                    
                }
            }
        }
    }
}

struct AddTodoSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheet()
    }
}
