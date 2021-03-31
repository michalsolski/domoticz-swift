@testable import DomoticzSwift
import Quick
import Nimble

final class DomoticzSwiftExampleSpec: QuickSpec {

    override func spec() {

        describe("domoticz") {
            beforeEach {
                // create sut
            }

            it("should say hello") {
                expect(DomoticzSwift().helloMsg).to(equal("hey there, hi there, ho there"))
            }
        }
    }
}
