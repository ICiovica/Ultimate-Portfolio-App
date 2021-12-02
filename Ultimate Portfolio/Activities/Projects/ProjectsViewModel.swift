//
//  ProjectsViewModel.swift
//  Ultimate Portfolio
//
//  Created by Ionut Ciovica on 02/12/2021.
//
import CoreData
import Foundation
import SwiftUI

extension ProjectsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var sortOrder = Item.SortOrder.optimized
        let dataController: DataController
        let showClosedProject: Bool
        private let projectsController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()
        init(dataController: DataController, showClosedProject: Bool) {
            self.dataController = dataController
            self.showClosedProject = showClosedProject
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "closed = %d", showClosedProject)
            projectsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil, cacheName: nil
            )
            super.init()
            projectsController.delegate = self
            do {
                try projectsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch our projects.")
            }
        }
        func addItem(to project: Project) {
                let item = Item(context: dataController.container.viewContext)
                item.project = project
                item.creationDate = Date()
                dataController.save()
        }
        func addProject() {
                let project = Project(context: dataController.container.viewContext)
                project.closed = false
                project.creationDate = Date()
                dataController.save()
        }
        func delete(_ offsets: IndexSet, from project: Project) {
            let allItems = project.projectItems(using: sortOrder)
            for offset in offsets {
                let item = allItems[offset]
                dataController.delete(item)
            }
            dataController.save()
        }
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
    }
}
