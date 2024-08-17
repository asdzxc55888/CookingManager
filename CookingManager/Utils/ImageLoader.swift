//
//  ImageLoader.swift
//  CookingManager
//
//  Created by 何韋辰 on 2024/8/17.
//

import Foundation

// MARK: loading system resource image
func loadImageData(name: String, withExtension: String?) -> Data? {
    if let url = Bundle.main.url(forResource: name, withExtension: withExtension),
        let data = try? Data(contentsOf: url) {
        return data
    }
    return nil
}
