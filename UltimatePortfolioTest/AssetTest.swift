//
//  AssetTests.swift
//  UltimatePortfolioTest
//
//  Created by Ionut Ciovica on 01/12/2021.
//

import XCTest
@testable import Ultimate_Portfolio

class AssetTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }
    func testJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load award from JSON")
    }
}
