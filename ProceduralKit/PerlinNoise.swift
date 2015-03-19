//
//  PerlinNoise.swift
//  ProceduralKit
//
//  Created by Rachel Brindle on 3/11/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import Foundation

public class PerlinNoise {
    let grid : [[(x: CGFloat, y: CGFloat)]]

    public var maxWidth : CGFloat {
        return CGFloat(grid[0].count - 1)
    }

    public var maxHeight : CGFloat {
        return CGFloat(grid.count - 1)
    }

    public class func generateGrid(length: Int, width: Int) -> [[(x: CGFloat, y: CGFloat)]] {
        var ret : [[(x: CGFloat, y: CGFloat)]] = []
        for x in 0..<(length+1) {
            var g : [(x: CGFloat, y: CGFloat)] = []
            for y in 0..<(width+1) {
                let a = CGFloat(arc4random_uniform(5000000)) / 5000000.0
                let b = sqrt(1 - a*a)
                g.append((x: a, y: b))
            }
            ret.append(g)
        }
        return ret
    }

    public init(grid: [[(x: CGFloat, y: CGFloat)]]) {
        self.grid = grid
    }

    func linearInterpolation(a: CGFloat, _ b: CGFloat, weight: CGFloat) -> CGFloat {
        return ((1.0 - weight) * a) + (weight * b)
    }

    func cosineInterpolation(a: CGFloat, _ b: CGFloat, weight: CGFloat) -> CGFloat {
        let x = weight * CGFloat(M_PI)
        return  linearInterpolation(a, b, weight: (1.0 - cos(x)) / 2.0)
    }

    func dotProductGradient(ix: Int, iy: Int, x: CGFloat, y: CGFloat) -> CGFloat {
        let dx = x - CGFloat(ix)
        let dy = y - CGFloat(iy)

        return (dx*grid[ix][iy].x + dy*grid[ix][iy].y)
    }

    public func at(x: CGFloat, _ y: CGFloat) -> CGFloat {
        let (x0, x1) = nearestValidXIntegers(x)
        let (y0, y1) = nearestValidYIntegers(x0, y: y)

        let weightX = x - CGFloat(x0)
        let weightY = y - CGFloat(y0)

        var n0 = dotProductGradient(x0, iy: y0, x: x, y: y)
        var n1 = dotProductGradient(x1, iy: y0, x: x, y: y)

        let ix0 = cosineInterpolation(n0, n1, weight: weightX)

        n0 = dotProductGradient(x0, iy: y1, x: x, y: y)
        n1 = dotProductGradient(x1, iy: y1, x: x, y: y)

        let ix1 = cosineInterpolation(n0, n1, weight: weightX)

        return cosineInterpolation(ix0, ix1, weight: weightY)
    }

    private func nearestValidXIntegers(var x: CGFloat) -> (Int, Int) {
        if grid.count < 2 {
            return (0,0)
        }
        if x < 0.0 {
            x = 0
        }
        if maxHeight <= x {
            x = maxHeight - 1
        }

        return (Int(x), Int(x+1))
    }

    private func nearestValidYIntegers(x: Int, var y: CGFloat) -> (Int, Int) {

        let g = grid[x]

        if g.count < 2 {
            return (0,0)
        }
        if y < 0.0 {
            y = 0
        }
        if maxWidth <= y {
            y = maxWidth - 1
        }

        return (Int(y), Int(y+1))
    }
}
