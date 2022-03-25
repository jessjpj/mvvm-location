//
//  DewaLocationModel.swift
//  Dewa
//
//  Created by Mac on 25/03/2022.
//

import Foundation

// MARK: - DewaLocationModel
struct DewaLocationModel: Codable {
    let locationsApp: LocationsApp?

    enum CodingKeys: String, CodingKey {
        case locationsApp = "LocationsApp"
    }
}

// MARK: DewaLocationModel convenience initializers and mutators

extension DewaLocationModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DewaLocationModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        locationsApp: LocationsApp?? = nil
    ) -> DewaLocationModel {
        return DewaLocationModel(
            locationsApp: locationsApp ?? self.locationsApp
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LocationsApp
struct LocationsApp: Codable {
    let fileVer, dist: String?
    let cordinate: Cordinate?

    enum CodingKeys: String, CodingKey {
        case fileVer = "FileVer"
        case dist = "Dist"
        case cordinate = "Cordinate"
    }
}

// MARK: LocationsApp convenience initializers and mutators

extension LocationsApp {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LocationsApp.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        fileVer: String?? = nil,
        dist: String?? = nil,
        cordinate: Cordinate?? = nil
    ) -> LocationsApp {
        return LocationsApp(
            fileVer: fileVer ?? self.fileVer,
            dist: dist ?? self.dist,
            cordinate: cordinate ?? self.cordinate
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Cordinate
struct Cordinate: Codable {
    let item: [DewaLocationItem]?
}

// MARK: Cordinate convenience initializers and mutators

extension Cordinate {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Cordinate.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        item: [DewaLocationItem]?? = nil
    ) -> Cordinate {
        return Cordinate(
            item: item ?? self.item
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Item
struct DewaLocationItem: Codable, Hashable {
    let id, office, lat, lon: String?
    let loc: String?
    var distance: Int?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: DewaLocationItem, rhs: DewaLocationItem) -> Bool {
        lhs.id == rhs.id && lhs.distance == rhs.distance
    }
}

// MARK: Item convenience initializers and mutators

extension DewaLocationItem {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DewaLocationItem.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        office: String?? = nil,
        lat: String?? = nil,
        lon: String?? = nil,
        loc: String?? = nil
    ) -> DewaLocationItem {
        return DewaLocationItem(
            id: id ?? self.id,
            office: office ?? self.office,
            lat: lat ?? self.lat,
            lon: lon ?? self.lon,
            loc: loc ?? self.loc
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
