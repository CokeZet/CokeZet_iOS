
import XCTest
class ShoppingMallSetUpTest: XCTestCase {
    private let item = "Hello"
    func test_first() throws {
        XCTAssertEqual(item, "Hello", "test_first Fail")
    }
}
