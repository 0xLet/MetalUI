import SwiftUI
import MetalKit

#if os(iOS)
public struct MetalView<Content>: UIViewRepresentable where Content: MetalPresenting {
    public var wrappedView: Content
    
    private var handleUpdateUIView: ((Content, Context) -> Void)?
    private var handleMakeUIView: ((Context) -> Content)?
    
    public init(closure: () -> Content) {
        wrappedView = closure()
    }
    
    public func makeUIView(context: Context) -> Content {
        guard let handler = handleMakeUIView else {
            return wrappedView
        }
        
        return handler(context)
    }
    
    public func updateUIView(_ uiView: Content, context: Context) {
        handleUpdateUIView?(uiView, context)
    }
}

public extension MetalView {
    mutating func setMakeUIView(handler: @escaping (Context) -> Content) -> Self {
        handleMakeUIView = handler
        
        return self
    }
    
    mutating func setUpdateUIView(handler: @escaping (Content, Context) -> Void) -> Self {
        handleUpdateUIView = handler
        
        return self
    }
}
#elseif os(macOS)
public struct MetalView<Content>: NSViewRepresentable where Content: MetalPresenting {
    public typealias NSViewType = Content
    
    public var wrappedView: Content
    
    private var handleUpdateNSView: ((Content, Context) -> Void)?
    private var handleMakeNSView: ((Context) -> Content)?
    
    public init(closure: () -> Content) {
        wrappedView = closure()
    }
    
    public func makeNSView(context: Context) -> Content {
        guard let handler = handleMakeNSView else {
            return wrappedView
        }
        
        return handler(context)
    }
    
    public func updateNSView(_ nsView: Content, context: Context) {
        handleUpdateNSView?(nsView, context)
    }
}

public extension MetalView {
    mutating func setMakeNSView(handler: @escaping (Context) -> Content) -> Self {
        handleMakeNSView = handler
        
        return self
    }
    
    mutating func setUpdateNSView(handler: @escaping (Content, Context) -> Void) -> Self {
        handleUpdateNSView = handler
        
        return self
    }
}

#endif


