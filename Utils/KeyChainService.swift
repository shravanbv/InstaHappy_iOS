//
//  KeyChainService.swift
//  InstaHappy
//
//  Copyright © 2019 Shravan. All rights reserved.
//

import Foundation

import KeychainSwift
class KeyChainService{
    var _keyChain = KeychainSwift()
    var keyChain: KeychainSwift{
        get{
            return _keyChain
        }
        set{
            _keyChain = newValue
        }
    }
}

