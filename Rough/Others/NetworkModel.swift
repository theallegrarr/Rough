//
//  NetworkModel.swift
//  Rough
//
//  Created by nurudeen on 09/07/2021.
//

import SwiftUI

struct Photo: Codable, Identifiable {
    let id: String
    let author: String
    let width, height: Int
    let url, download_url: URL
}

struct PhotoLoadingError: Error { }
