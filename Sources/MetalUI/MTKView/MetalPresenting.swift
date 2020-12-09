import MetalKit

public protocol MetalPresenting: MTKView {
    var renderer: MetalRendering! { get set }
    
    init()
    
    func configure(device: MTLDevice?)
    
    func configureMTKView()
    func renderer(forDevice device: MTLDevice) -> MetalRendering
}

public extension MetalPresenting {
    
    func configure(device: MTLDevice? = MTLCreateSystemDefaultDevice()) {
        // Make sure we are on a device that can run metal!
        guard let defaultDevice = device else {
            fatalError("Device loading error")
        }
        
        self.renderer = renderer(forDevice: defaultDevice)
        self.delegate = renderer
        self.configureMTKView()
    }
}
