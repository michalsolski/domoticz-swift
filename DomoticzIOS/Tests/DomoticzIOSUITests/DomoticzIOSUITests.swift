//
//  DomoticzIOSUITests.swift
//  DomoticzIOSUITests
//
//  Created by Michał Solski on 30/03/2021.
//

import XCTest
import Quick
import Nimble

final class DomoticzIOSUITestsExampleSpec: QuickSpec {

    override func spec() {

        var app: XCUIApplication!

        describe("ui tests") {

            beforeEach {
                app = XCUIApplication()
                app.launch()
            }

            it("test should pass") {
                expect(true).to(beTrue())
            }
        }
    }
}
