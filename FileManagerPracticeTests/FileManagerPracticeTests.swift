//
//  FileManagerPracticeTests.swift
//  FileManagerPracticeTests
//
//  Created by Benjamin Stone on 2/18/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import XCTest
@testable import FileManagerPractice

class FileManagerPracticeTests: XCTestCase {
    func testCharacters() {
        let data = getTestCharactersJSONData()
        let characters = RickAndMortyCharacter.characters(from: data)
        XCTAssertEqual(characters.count, 20, "Was expecting 20 characters, but found \(characters.count)")
    }
    private func getTestCharactersJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "charactersTestJSON", ofType: "json") else {
            fatalError("charactersTestJSON.json file not found")
        }
        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }
}

