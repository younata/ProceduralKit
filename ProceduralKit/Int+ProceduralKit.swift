//
//  Int+ProceduralKit.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/19/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

extension Int {
    func isRelativelyPrimeTo(to: Int) -> Bool {
        return greatestCommonDivisor(self, to) == 1
    }

    func isDivisibleBy(by: Int) -> Bool {
        return (self % by) == 0
    }

    var primeFactors : Set<Int> {
        var ret = Set<Int>()

        var x = self
        var i = 2
        while i < x {
            if x % i == 0 {
                ret.insert(x)
                x /= i
            } else {
                i++
            }
        }

        return ret
    }

    var prime : Bool {
        return primeFactors.count == 0
    }
}