import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ARServer2_0Tests.allTests),
    ]
}
#endif
