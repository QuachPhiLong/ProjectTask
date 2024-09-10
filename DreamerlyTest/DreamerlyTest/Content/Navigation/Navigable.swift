//
//  File.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import Foundation

protocol Navigable {
    associatedtype NavigationItem: Equatable
    
    var onNavigation: ((NavigationItem) -> Void)! { get }
}
