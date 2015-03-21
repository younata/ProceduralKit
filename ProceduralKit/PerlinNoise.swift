//
//  PerlinNoise.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

public class PerlinNoise {

    let noiseFunc : (Double, Double) -> (Double)

    public init(noise: (Double, Double) -> (Double)) {
        self.noiseFunc = noise
    }

    func linearInterpolation(a: Double, _ b: Double, weight: Double) -> Double {
        return ((1.0 - weight) * a) + (weight * b)
    }

    func cosineInterpolation(a: Double, _ b: Double, weight: Double) -> Double {
        let x = weight * Double(M_PI)
        return  linearInterpolation(a, b, weight: (1.0 - cos(x)) / 2.0)
    }

    func dotProductGradient(ix: Int, iy: Int, x: Double, y: Double) -> Double {
        let dx = x - Double(ix)
        let dy = y - Double(iy)

        return (dx * noiseFunc(Double(ix), Double(iy)) + dy * noiseFunc(Double(ix), Double(iy))) / 2.0
    }

    public func at(x: Double, _ y: Double) -> Double {
        let (x0, x1) = nearestValidXIntegers(x)
        let (y0, y1) = nearestValidYIntegers(x0, y: y)

        let weightX = x - Double(x0)
        let weightY = y - Double(y0)

        var n0 = dotProductGradient(x0, iy: y0, x: x, y: y)
        var n1 = dotProductGradient(x1, iy: y0, x: x, y: y)

        let ix0 = cosineInterpolation(n0, n1, weight: weightX)

        n0 = dotProductGradient(x0, iy: y1, x: x, y: y)
        n1 = dotProductGradient(x1, iy: y1, x: x, y: y)

        let ix1 = cosineInterpolation(n0, n1, weight: weightX)

        return cosineInterpolation(ix0, ix1, weight: weightY)
    }

    private func nearestValidXIntegers(var x: Double) -> (Int, Int) {
        return (Int(x), Int(x+1))
    }

    private func nearestValidYIntegers(x: Int, var y: Double) -> (Int, Int) {
        return (Int(y), Int(y+1))
    }
}
