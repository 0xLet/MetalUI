import MetalKit

public protocol MetalRendering: NSObject, MTKViewDelegate {
    var commandQueue: MTLCommandQueue? { get set }
    var renderPipelineState: MTLRenderPipelineState? { get set }
    var vertexBuffer: MTLBuffer? { get set }
    
    var vertices: [MetalRenderingVertex] { get set }
    
    init()
    init(
        vertices: [MetalRenderingVertex],
        device: MTLDevice
    )
    
    func createCommandQueue(device: MTLDevice)
    func createPipelineState(
        withLibrary library: MTLLibrary?,
        forDevice device: MTLDevice
    )
    func createBuffers(device: MTLDevice)
    
    // MARK: MTKViewDelegate
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize)
    func draw(in view: MTKView)
}

public extension MetalRendering {
    init(vertices: [MetalRenderingVertex], device: MTLDevice) {
        self.init()
        
        self.vertices = vertices
        
        createCommandQueue(device: device)
        createPipelineState(withLibrary: device.makeDefaultLibrary(), forDevice: device)
        createBuffers(device: device)
    }
}
