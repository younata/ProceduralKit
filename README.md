##ProceduralKit - Swift framework for procedurally generated noise.

This library generates [2D Perlin Noise](https://en.wikipedia.org/wiki/Perlin_noise) and also 2d [Fractal Brownian Motion](https://en.wikipedia.org/wiki/Fractional_Brownian_motion).

Perlin noise is useful for generating procedurally generated things. It provides smoothed random numbers. However, because they're smoothed, the images it produces are a bit blurry. To combat this, the noise is basically repeated onto itself a number of times, which produces more 'sharp' images. This last bit is the Fractal Brownian Motion.

###Usage

```swift
import ProceduralKit

let noise = ProceduralKit.PerlinNoise(grid: ProceduralKit.PerlinNoise.generateGrid(100, width: 100))
let motion = FractalBrownianMotion()
motion.noise = {(x, y) in noise.at(x, y)}

let value = motion.at(2,3)
```

There are some caveats, namely that, while it won't error on you if you try to access values below 0 and above whatever the max height(y) or width(x).

You can also specify your own grid, which should be an array of array of tuples (the type is `[[(x: CGFloat, y: CGFloat)]]`). Each of the tuples should be a vector on the unit circle (that is, x^2 + y^2 should equal 1).

###Installation

Use Carthage. `github "younata/ProceduralKit"`
