import MetalKit

public struct MetalRenderingVertex {
    public var position: SIMD3<Float>
    public var color: SIMD4<Float>
    
    public init(
        position: SIMD3<Float>,
        color: SIMD4<Float>
    ) {
        self.position = position
        self.color = color
    }
}
