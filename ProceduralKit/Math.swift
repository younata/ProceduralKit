//
//  Math.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/19/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

// simple linear-congruential generator.
// Defaults are gcc's values.
func noise(x: Int, multiplier: Int = 1103515245, constant: Int = 12345, modulus: Int = 0x10000000) -> Double {
    return Double((multiplier * x + constant) % modulus) / Double(modulus)
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