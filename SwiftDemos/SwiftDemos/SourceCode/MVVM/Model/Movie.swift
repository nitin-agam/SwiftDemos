//
//  Movie.swift
//  SwiftDemos
//
//  Created by Nitin A on 03/06/19.
//  Copyright © 2019 Nitin A. All rights reserved.
//

import Foundation

class Movie {
    
    var artistName: String?
    var trackName: String?
    
    init(artist: String, track: String) {
        self.artistName = artist
        self.trackName = track
    }
}


class MovieResult {
    
    var movies = [Movie]()
    
    init(results: [Movie]) {
        self.movies = results
    }
}
