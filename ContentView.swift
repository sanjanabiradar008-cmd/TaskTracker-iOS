import SwiftUI

// 1. The data structure for your tasks
struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    // 2. The array managing your tasks
    @State private var tasks = [
        TaskItem(title: "Set up GitHub repository", isCompleted: true),
        TaskItem(title: "Install development tools", isCompleted: true),
        TaskItem(title: "Design TaskTracker UI", isCompleted: false),
        TaskItem(title: "Add new task feature", isCompleted: false)
    ]
    
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Input section at the top
                HStack {
                    TextField("Enter new task...", text: $newTaskTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            tasks.append(TaskItem(title: newTaskTitle))
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // The task list display
                List {
                    // Using indices safely with the task array's range
                    ForEach(tasks.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(tasks[index].isCompleted ? .green : .gray)
                                .onTapGesture {
                                    tasks[index].isCompleted.toggle()
                                }
                            
                            Text(tasks[index].title)
                                .font(.body)
                                .strikethrough(tasks[index].isCompleted)
                                .foregroundColor(tasks[index].isCompleted ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: deleteTask) // Enables swipe-to-delete
                }
            }
            .navigationTitle("My Tasks")
        }
    }
    
    // 3. Helper function to remove items
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
