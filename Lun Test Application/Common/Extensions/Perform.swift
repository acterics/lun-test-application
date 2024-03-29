//
//  Perform.swift
//

import Foundation
import UIKit
import Rswift
import Aspects

extension UIViewController {
    /// Perform the storyboard segue identified by `segue`, invoking `prepare`
    /// with the destination view controller when `prepareForSegue(_:sender:)`
    /// is received.
    ///
    /// **Example**
    ///
    ///     // prepare for segue inside the closure
    ///     perform(.showTaskDetails) { taskVC in
    ///       taskVC.task = self.selectedTask
    ///     }
    ///
    ///     // just perform a segue
    ///     perform(.signOut)
    ///
    /// If the destination view controller itself doesn't match the destination
    /// type specified by `segue`, its view controller hierarchy is searched
    /// until the matching view controller is found. For example, if the desired
    /// view controller is embedded inside a `UINavigationController`, it will
    /// still be found and passed along to `prepare`.
    ///
    /// - parameter segue:
    ///     An instance of `Segue<Destination>` which specifies the identifier
    ///     and destination view controller type.
    ///
    /// - parameter prepare:
    ///     A function that will be invoked with the matching destination view
    ///     view controller when `prepareForSegue(_:sender:)` is received. The
    ///     default value for this parameter does nothing.
    ///
    /// - note:
    ///     If no matching view controller is found in the destination
    ///     view controller hierarchy, this method will raise a fatal error
    ///     and crash. This usually means that the view controller hasn't
    ///     been configured with the correct type in the storyboard.
    public func perform<Segue, Source, Destination>(_ segue: StoryboardSegueIdentifier<Segue, Source, Destination>, prepare: @escaping (Destination) -> Void = { _ in }) {
        performSegue(withIdentifier: segue.identifier) { [segueDescription = { String(reflecting: segue) }] segue, _ in
            guard let destination = segue.destination as? Destination else {
                fatalError("\(segueDescription()): expected destination view controller hierarchy to include \(Destination.self)")
            }
            
            prepare(destination)
        }
    }
    
    internal func performSegue(withIdentifier identifier: String, sender: Any? = nil, prepare: @escaping (UIStoryboardSegue, Any?) -> Void) {
        _ = try! aspect_hook(
            #selector(UIViewController.prepare(for:sender:)),
            options: .optionAutomaticRemoval,
            body: { info in
                let arguments = info.arguments()!
                prepare(arguments[0] as! UIStoryboardSegue, arguments[1])
        }
        )
        
        performSegue(withIdentifier: identifier, sender: sender)
    }
}

// MARK: - Type checker ambiguity hack
extension UIViewController {
    @available(*, unavailable)
    public func perform() {
        fatalError(
            "This method will never be called, and exists only to remove an " +
            "apparent ambiguity resolving the generic method 'perform(_:prepare:)'"
        )
    }
}



extension NSObject {
    @nonobjc final func aspect_hook(_ selector: Selector, options: AspectOptions, body: @convention(block) @escaping (AspectInfo) -> Void) throws -> AspectToken {
        return try self.aspect_hook(selector, with: options, usingBlock: unsafeBitCast(body, to: NSObject.self))
    }
}
