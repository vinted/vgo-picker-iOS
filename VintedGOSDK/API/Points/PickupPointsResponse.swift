import Foundation

public struct Point: Decodable {
    
    public let carrier: String
    public let service: String
    public let distance: Double
    public let distanceUnit: String
    public let point: PointDetails
    
    init(carrier: String, service: String, distance: Double, distanceUnit: String, point: PointDetails) {
        self.carrier = carrier
        self.service = service
        self.distance = distance
        self.distanceUnit = distanceUnit
        self.point = point
    }
    
    enum CodingKeys: String, CodingKey {
        case carrier, service, distance
        case distanceUnit = "distance_unit"
        case point
    }
}

public struct PointDetails: Decodable {
    
    public let code: String
    public let name: String
    public let pointDescription: String
    public let addressLine1: String
    public let addressLine2: String
    public let postalCode: String
    public let city: String
    public let countryCode: String
    public let latitude: String
    public let longitude: String
    public let photoURL: String
    public let businessHours: [BusinessHour]
    
    init(code: String,
         name: String,
         pointDescription: String,
         addressLine1: String,
         addressLine2: String,
         postalCode: String,
         city: String,
         countryCode: String,
         latitude: String,
         longitude: String,
         photoURL: String,
         businessHours: [BusinessHour]) {
        self.code = code
        self.name = name
        self.pointDescription = pointDescription
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.postalCode = postalCode
        self.city = city
        self.countryCode = countryCode
        self.latitude = latitude
        self.longitude = longitude
        self.photoURL = photoURL
        self.businessHours = businessHours
    }
    
    enum CodingKeys: String, CodingKey {
        case code, name
        case pointDescription = "description"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case postalCode = "postal_code"
        case city
        case countryCode = "country_code"
        case latitude, longitude
        case photoURL = "photo_url"
        case businessHours = "business_hours"
    }
}

public struct BusinessHour: Decodable {
    
    public let weekday: String
    public let opensAt: String
    public let closesAt: String
    
    init(weekday: String, opensAt: String, closesAt: String) {
        self.weekday = weekday
        self.opensAt = opensAt
        self.closesAt = closesAt
    }
    
    enum CodingKeys: String, CodingKey {
        case weekday
        case opensAt = "opens_at"
        case closesAt = "closes_at"
    }
}

public typealias PickupPointsResponse = [Point]
