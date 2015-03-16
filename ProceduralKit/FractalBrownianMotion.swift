//
//  FractalBrownianMotion.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

public class FractalBrownianMotion {
    public var lacunarity : CGFloat = 2.0
    public var octaves : Int = 3
    private var gain : CGFloat {
        return 1.0 / self.lacunarity
    }

    private let length : CGFloat = 100.0

    public var noise : (CGFloat, CGFloat) -> CGFloat = {(_, _) in 1}

    public init() {}

    public func at(x: CGFloat, _ y: CGFloat) -> CGFloat {
        var total : CGFloat = 0.0
        var frequency : CGFloat = 1.0 / length
        var amplitude = gain
        for i in 0..<octaves {
            let n = noise(x * frequency, y * frequency)
            total += n * amplitude
            frequency *= lacunarity
            amplitude *= gain
        }
        return total
    }
}