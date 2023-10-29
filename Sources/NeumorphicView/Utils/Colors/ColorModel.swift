//
//  ColorModel.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

protocol ColorModel {
    var color: Color { get }
    init?(color: Color)
}
