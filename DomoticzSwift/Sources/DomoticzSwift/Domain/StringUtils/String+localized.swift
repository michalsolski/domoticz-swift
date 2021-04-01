//
//  String+localized.swift
//  
//
//  Created by Michał Solski on 03/04/2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.module, comment: "")
    }
}
