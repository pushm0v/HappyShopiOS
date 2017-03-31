//
//  AppRouter.swift
//  happyshop
//
//  Created by Bherly Novrandy on 2/8/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit
import Swinject

protocol IAppRouter  {
    var resolver: Resolver { get }
    
    func displayView(view: UIViewController?, animateDismiss: Bool, animateDisplay: Bool)
    func displayView(view: UIViewController?, animateDismiss: Bool, animateDisplay: Bool, completion:(() -> Void)?)
    func displayViewWithoutDismiss(view: UIViewController?,animateDisplay:Bool)
    func dismissViewFromNavigationController(animated: Bool,completion: ()->())
    
    func presentViewModally(view: UIViewController)
    func presentView(view: UIViewController)
    func dismissView()
}

class AppRouter: BaseAppRouter {
    static let sharedInstance = AppRouter.createAppRouter()
    
    private static func createAppRouter() -> AppRouter {
        let rootVC = UIApplication.shared.delegate!.window!!.rootViewController!
        let navController = { () -> UINavigationController in
            let nav = UINavigationController()
            
            nav.navigationBar.isTranslucent = true
            return nav
        }()
        
        let assembler = Assembler()
        assembler.apply(assemblies: [CommonAssembly(), HomeAssembly(), ItemsAssembly()])
        
        let products: [String: (_ appRouter: IAppRouter) -> IProductRouter] = [
            Products.ShopProduct.productName: { ShopRouter(router: $0) }
        ]
        let router = AppRouter(rootVC: rootVC, navigationController: navController, assembler: assembler, products: products)
        return router
    }
}
