//
//  FractalBrownianMotion.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

public class FractalBrownianMotion {
    public var lacunarity : Double = 2.0
    public var octaves : Int = 6
    public var gain : Double = 0.65
    public var initialFrequency : Double = 0.01

    public var noise : (Double, Double) -> Double = {(_, _) in 1}

    public init() {}

    public func at(x: Double, _ y: Double) -> Double {
        var total : Double = 0.0
        var frequency = initialFrequency
        var amplitude = gain
        for i in 0..<octaves {
            let n = noise(x * frequency, y * frequency)
            total += n * amplitude
            frequency *= lacunarity
            amplitude *= gain
        }
        return total / Double(octaves)
    }
}