//
//  Helpers.swift
//  LadoTsivtsivadze_15
//
//  Created by Ladolado3911 on 5/19/21.
//

import Foundation
import UIKit

enum Method {
    case withBackItem
    case withoutBackItem
}

func getController(storyboardID id: StoryboardID, controllerID identifier: ControllerID) -> UIViewController {
    let vc = UIStoryboard(name: id.rawValue, bundle: nil).instantiateViewController(identifier: identifier.rawValue)
    
    return vc
}

func pushController(from controller1: UIViewController, to controller2: UIViewController, method mtd: Method) {
    controller1.navigationController?.navigationBar.isHidden = mtd == .withoutBackItem ? true : false
    //controller1.navigationController?.navigationBar.items = nil
    controller1.navigationController?.pushViewController(controller2, animated: true)
}

func popController(from controller: UIViewController, method mtd: Method) {
    controller.navigationController?.navigationBar.isHidden = mtd == .withoutBackItem ? true : false
    controller.navigationController?.popViewController(animated: true)
}

func pushPageController(from controller1: UIViewController, to controller2: UIPageViewController, method mtd: Method) {
    controller1.navigationController?.navigationBar.isHidden = mtd == .withoutBackItem ? true : false
    controller1.navigationController?.pushViewController(controller2, animated: true)
}

func pushTabBarController(from controller1: UIViewController, to tabbarController: UITabBarController) {
    tabbarController.modalPresentationStyle = .fullScreen
    controller1.present(tabbarController, animated: true, completion: nil)
}

//func getTabBarController(storyboardID id1: StoryboardID, controllerID id2: TabbarControllerID) -> TabbarController {
//    let tb = UIStoryboard(name: id1.rawValue, bundle: nil).instantiateViewController(identifier: id2.rawValue) as? TabbarController
//    return tb!
//}
