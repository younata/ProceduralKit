import Quick
import Nimble

class MathSpec: QuickSpec {
    override func spec() {
        describe("noise") {
            it("should produce repeatable noise from a given value") {
                expect(noise(10)).to(beCloseTo(0.109192, within: 1e-6))
                expect(noise(5)).to(beCloseTo(0.554619, within: 1e-6))
            }

            it("should produce 2d repeatable noise from given values") {
                expect(noise(10, y: 10)).to(beCloseTo(0.109192, within: 1e-6))
                expect(noise(10, y: 5)).to(beCloseTo(0.331905, within: 1e-6))
            }
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
