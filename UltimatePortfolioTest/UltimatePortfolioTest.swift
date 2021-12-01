//
//  UltimatePortfolioTest.swift
//  UltimatePortfolioTest
//
//  Created by Ionut Ciovica on 01/12/2021.
//
import CoreData
import XCTest
@testable import Ultimate_Portfolio

class BaseTestCase: XCTestCase {

    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
