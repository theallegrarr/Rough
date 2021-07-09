//
//  DataModel.swift
//  Rough
//
//  Created by nurudeen on 06/06/2021.
//

import Foundation

/*
 "Search": {
     "Title": "Blade Runner",
     "Year": "1982",
     "imdbID": "tt0083658",
     "Type": "movie",
     "Poster": "https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg"
  }
*/

struct IMDBSearchResponse: Decodable {
    let Search : [MovieObject]
}

struct MovieObject: Decodable {
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}
