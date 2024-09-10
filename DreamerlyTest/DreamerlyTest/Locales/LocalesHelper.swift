//
//  LocalesHelper.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import Localize_Swift

func Localize_Swift_bridge(forKey:String,table:String,fallbackValue:String)->String {
    return forKey.localized(using: table);
}
