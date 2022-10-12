extension Map {

    struct Region: Equatable {

        let center: Coordinate
        let size: Size

        static var world: Region {
            .init(
                center: Map.Coordinate(latitude: 0, longitude: 0),
                size: Size(latitudalMeters: 100_000_00, longitudalMeters: 100_000_00)
            )
        }
    }
}

extension Map.Region {

    struct Size: Equatable {

        let latitudalMeters: Double
        let longitudalMeters: Double

        init(latitudalMeters: Double, longitudalMeters: Double) {
            self.latitudalMeters = latitudalMeters
            self.longitudalMeters = longitudalMeters
        }

        init(latitudalRadius: Double, longitudalRadius: Double) {
            self.init(latitudalMeters: latitudalRadius * 2, longitudalMeters: longitudalRadius * 2)
        }
    }
}
