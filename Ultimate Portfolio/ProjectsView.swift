//
//  ProjectView.swift
//  Ultimate Portfolio
//
//  Created by Ionut Ciovica on 27/11/2021.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let showClosedProject: Bool
    
    let projects: FetchRequest<Project>
    
    init(showClosedProject: Bool) {
        self.showClosedProject = showClosedProject
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProject))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                        }
                        .onDelete { offsets in
                            let allItems = project.projectItems
                            
                            for offset in offsets {
                                let item = allItems[offset]
                                dataController.delete(item)
                            }
                            
                            dataController.save()
                        }
                        
                        if showClosedProject == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add New Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProject ? "Closed Projects" : "Open Projects")
            .toolbar {
                if showClosedProject == false {
                    Button {
                        withAnimation {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        }
                    } label: {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProject: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
