//
//  ItemRowViewModel.swift
//  Ultimate Portfolio
//
//  Created by Ionut Ciovica on 02/12/2021.
//

import Foundation

extension ItemRowView {
    class ViewModel: ObservableObject {
        let project: Project
        let item: Item
        var title: String {
            item.itemTitle
        }
        init(project: Project, item: Item) {
            self.project = project
            self.item = item
        }
        var icon: String {
            if item.completed {
                return "checkmark.circle"
            } else if item.priority == 3 {
                return "exclamationmark.triangle"
            } else {
                return "checkmark.circle"
            }
        }
        var color: String? {
            if item.completed {
                return project.projectColor
            } else if item.priority == 3 {
                return project.projectColor
            } else {
                return nil
            }
        }
        var label: String {
            if item.completed {
                return String("\(item.itemTitle), completed.")
            } else if item.priority == 3 {
                return String("\(item.itemTitle), high priority.")
            } else {
                return String(item.itemTitle)
            }
        }
    }
}
