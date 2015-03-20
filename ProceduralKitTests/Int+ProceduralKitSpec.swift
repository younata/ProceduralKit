import Quick
import Nimble

class Int_ProceduralKitSpec: QuickSpec {
    override func spec() {
        describe("-isRelativelyPrimeTo:") {
            it("should determine whether a number is relatively prime to the receiver") {
                expect(4.isRelativelyPrimeTo(2)).to(beFalsy())

                expect(9.isRelativelyPrimeTo(8)).to(beTruthy())
            }
        }

        describe("-isDivisibleBy:") {
            it("should determine whether the receiver is divisible by a number") {
                expect(10.isDivisibleBy(5)).to(beTruthy())
                expect(9.isDivisibleBy(8)).to(beFalsy())
            }
        }

        describe("primeFactors") {
            it("should return the set of prime factors for a number") {
                expect(10.primeFactors).to(equal(Set([1,2,5,10])))
            }
        }

        describe("prime") {
            it("should determine whether a number is prime or not") {
                expect(1.prime).to(beFalsy())
                expect(2.prime).to(beTruthy())
                expect(3.prime).to(beTruthy())
                expect(4.prime).to(beFalsy())
                expect(5.prime).to(beTruthy())
                expect(6.prime).to(beFalsy())
                expect(7.prime).to(beTruthy())
                expect(8.prime).to(beFalsy())
                expect(9.prime).to(beFalsy())
                expect(10.prime).to(beFalsy())
                expect(11.prime).to(beTruthy())
            }
        }
    }
}
