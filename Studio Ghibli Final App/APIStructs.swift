//
//  APIStructs.swift
//  Studio Ghibli Final App
//
//  Created by administrator on 06/01/2022.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let id, title, originalTitle, originalTitleRomanised: String
    let image, movieBanner: String
    let welcomeDescription, director, producer, releaseDate: String
    let runningTime, rtScore: String
    let people, species, locations, vehicles: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case image
        case movieBanner = "movie_banner"
        case welcomeDescription = "description"
        case director, producer
        case releaseDate = "release_date"
        case runningTime = "running_time"
        case rtScore = "rt_score"
        case people, species, locations, vehicles, url
    }
}

typealias Movies = [Movie]


import Foundation

// MARK: - Person
struct Person: Codable {
    let id, name: String
    let gender: Nder?
    let age, eyeColor, hairColor: String
    let films: [String]
    let species, url: String
    let gander: Nder?

    enum CodingKeys: String, CodingKey {
        case id, name, gender, age
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case films, species, url, gander
    }
}

enum Nder: String, Codable {
    case female = "Female"
    case male = "Male"
    case na = "NA"
}

typealias People = [Person]


