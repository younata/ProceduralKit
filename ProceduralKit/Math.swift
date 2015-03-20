//
//  Math.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/19/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

// simple linear-congruential generator.
// Defaults are C++11's values.
func noise(x: Int, multiplier: Int = 48271, constant: Int = 0, modulus: Int = 0x7FFFFFFF) -> Double {
    return 0
//    return Double((multiplier * x + constant) % 0xFFFFFFFF) / Double(0xFFFFFFFF)
}

func greatestCommonDivisor(a: Int, b: Int) -> Int {
    var x = max(a, b)
    var y = min(a, b)
    while y != 0 {
        let t = y
        y = x % y
        x = t
    }
    return x
}