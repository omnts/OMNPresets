import OMNTools
import Foundation

public struct OMNPresets {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

open class Car {
    fileprivate(set) var model: String

    public init(model: String) {
        self.model = model
    }

    @objc public func show() {
        print("This car is a \(model)")
        let tool = MathsSuitable(range: 5)
        let fact5 = tool.facto(n: 5)
        print("Factorial(5) = \(fact5)")
    }
}
