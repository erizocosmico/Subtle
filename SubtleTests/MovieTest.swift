//
//  MovieTest.swift
//  Subtle
//
//  Created by Miguel Molina on 05/02/16.
//  Copyright © 2016 Miguel Molina. All rights reserved.
//

import XCTest
@testable import Subtle

struct TestCase {
    var path: String
    var expect: Bool
}

class MovieTest: XCTestCase {

    func testIsMovie() {
        let tests = [
            TestCase(path: "/bar/foo.mp4", expect: true),
            TestCase(path: "/bar/foo.avi", expect: true),
            TestCase(path: "/bar/foo.mov", expect: true),
            TestCase(path: "/bar/foo.mkv", expect: true),
            TestCase(path: "/bar/foo.mp3", expect: false),
            TestCase(path: "/bar/foo.srt", expect: false),
        ]

        for t in tests {
            XCTAssertEqual(Subtle.isMovie(t.path), t.expect)
        }
    }
    
}
