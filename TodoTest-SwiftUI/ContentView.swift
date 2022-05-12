//
//  ContentView.swift
//  TodoTest-SwiftUI
//
//  Created by James Christian Wira on 13/05/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.createdAt)],
        animation: .default)
    private var todos: FetchedResults<TodoItem>

    @State var showSheet: Bool = false
    @State var showAlert: Bool = false
    @State var refreshingId: UUID = UUID()
    
    var body: some View {
        NavigationView {
            ScrollView{
                if (todos.isEmpty) {
                    Text("No todo data")
                } else {
                    ForEach(todos) { todo in
                        VStack {
                            Text(todo.title ?? "")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(todo.content ?? "")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                        }
                        .padding(.horizontal, 16)
                    }
                    .id(refreshingId)
                    .padding(.top, 16)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Simple Todo List")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                        Text("Add New")
                    }
                }
                ToolbarItem() {
                    Button {
                        showAlert.toggle()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
//                        Text("Delete all")
                    }
                    .alert("Delete All Todo Data?", isPresented: $showAlert){
                        Button("Ok", role: .destructive) {
                            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TodoItem")
                            
                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                            do {
                                try moc.save()
                                try moc.execute(deleteRequest)
                                moc.reset()
                                
                                refreshingId = UUID()
                            } catch _ as NSError {
                                print("Deleting data failed")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                
            } content: {
                AddTodoSheet()
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
