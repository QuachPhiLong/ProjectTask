//
//  GlobalModel.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import SwiftUI
import Localize_Swift
import CoreStore

class GlobalModel: ObservableObject {
    @Published var languague: String = "en" {
        didSet {
            Localize.setCurrentLanguage(languague)
        }
    }
    
    @Published var isShowMenu: Bool = false
    @Published var isShowTabbar: Bool = true
    
    func toggleShowMenu(){
        if isShowMenu {
            isShowMenu = false
        } else {
            isShowMenu = true
        }
		setShowTabbar(!isShowMenu)
    }
    
    func setShowTabbar(_ _isShowTabbar: Bool){
        isShowTabbar = _isShowTabbar
    }
    
    func toggleLanguague() {
        if languague == "en" {
            languague = "vi"
        } else {
            languague = "en"
        }
    }
    
}
