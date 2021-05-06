import XCTest
@testable import Redux1

final class Redux1Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Redux1().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
