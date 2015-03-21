//
//  Math.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/19/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

// simple linear-congruential generator.
// Defaults are gcc's values.
public func noise(x: Double, y: Double? = nil, multiplier: Double = 1103515245, constant: Double = 12345, modulus: Double = 0x10000000) -> Double {
    let a = (multiplier * x + constant) % modulus / modulus
    if let w = y {
        let b = (multiplier * w + constant) % modulus / modulus
        return (a + b) / 2.0
    }
    return a
}

public func greatestCommonDivisor(a: Int, b: Int) -> Int {
    var x = max(a, b)
    var y = min(a, b)
    while y != 0 {
        let t = y
        y = x % y
        x = t
    }
    return x
}