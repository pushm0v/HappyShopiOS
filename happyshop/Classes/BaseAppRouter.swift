//
//  BaseAppRouter.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import Foundation
import Swinject

public protocol IProductRouter : class {
    func presentModule(module: Module, parameters:[String:AnyObject])
}

public class BaseAppRouter : IAppRouter {
    private let rootVC:UIViewController!
    private let assembler:Assembler!
    private let products : [String:(_ appRouter:IAppRouter)->IProductRouter]
    private let navigationController:UINavigationController?
    
    init(rootVC:UIViewController, navigationController:UINavigationController?, assembler:Assembler, products:[String:(_ appRouter:IAppRouter)->IProductRouter]){
        self.rootVC = rootVC
        self.navigationController = navigationController
        self.assembler = assembler
        self.products = products
    }
    
    public var resolver: Resolver {
        return assembler.resolver
    }
    
    public func presentModule(module: Module, parameters: [String:AnyObject]) {
        if let productConstuctor = products[module.productName] {
            let product = productConstuctor(self)
            product.presentModule(module: module, parameters: parameters)
        }
    }
    
    public func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool){
        displayView(view: view, animateDismiss:animateDismiss, animateDisplay:animateDisplay, completion:nil)
    }
    
    public func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool, completion:(() -> Void)?){
        rootVC.dismiss(animated: animateDismiss, completion: {() in
            if(view != nil){
                self.rootVC.present(view!, animated: animateDisplay, completion: completion)
            }
        })
    }
    
    public func displayViewWithoutDismiss(view:UIViewController?,animateDisplay:Bool) {
        view?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view!, animated: true)
    }
    
    public func dismissViewFromNavigationController(animated: Bool, completion: ()->()) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func presentViewModally(view: UIViewController) {
        rootVC.present(view, animated: true, completion: nil)
    }
    
    public func presentView(view: UIViewController) {
        // Top most VC
        var vc: UIViewController? = rootVC
        while vc != nil {
            if let next = vc?.presentedViewController {
                vc = next
            } else {
                break
            }
        }
        
        if let navController = vc as? UINavigationController {
            navController.pushViewController(view, animated: true)
        }
    }
    
    public func dismissView() {
        var vc: UIViewController? = rootVC
        while vc != nil {
            if let next = vc?.presentedViewController {
                vc = next
            } else {
                break
            }
        }
        vc?.dismiss(animated: true, completion: nil)
    }
    
    public func presentRoutePath(routePath: String, parameters: [String:AnyObject]) {
        self.presentModule(module: Products.Shop.getModule(routePath: routePath) , parameters: parameters)
    }
}
