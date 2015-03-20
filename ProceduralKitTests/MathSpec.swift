import Quick
import Nimble

class MathSpec: QuickSpec {
    override func spec() {
        describe("noise") {
        }

        describe("greatestCommonDivisor") {
            it("should correctly calculate the GCD of two ints.") {
                expect(greatestCommonDivisor(48, 49)).to(equal(1))
                expect(greatestCommonDivisor(24, 28)).to(equal(4))
                expect(greatestCommonDivisor(128, 256)).to(equal(128))
            }
        }
    }
}
