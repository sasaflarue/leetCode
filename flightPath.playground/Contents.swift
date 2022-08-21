// list all flights to and from destinations

struct Flight {
    let origin: String
    let destination: String
    
    init(_ origin: String, _ destination: String) {
        self.origin = origin
        self.destination = destination
    }
    public var description: String { return "\(origin)->\(destination)"}
}

func findItineraries(flights: [Flight], from: String, to: String) {
    var itineraries = [[Flight]]()
    var flightList = flights
    
    for (index, flight) in flightList.enumerated() {
        if flight.origin == from  {
            if flight.destination == to {
                itineraries.append([flight])
            } else {
                _ = flightList.remove(at: index)
                if let itinerary = dfs(flights: flightList, from: flight.destination, to: to) {
                    itinerary.forEach {
                        let curItin = [flight] + $0
                        itineraries.append(curItin)
                    }
                }
            }
        }
    }

    itineraries.forEach {
        $0.forEach {
            print("\($0.description)->", terminator: "")
        }
        print("")
    }
}

private func dfs(flights: [Flight]?, from: String, to: String) -> [[Flight]]? {
    guard let flights = flights else {
        return nil
    }
    
    if flights.count == 1 && flights[0].destination == to {
        return [flights]
    }
    var itineraries = [[Flight]]()
    
    for (index, flight) in flights.enumerated() {
        if flight.origin == from  {
            var flightList = flights
            _ = flightList.remove(at: index)
//            print("from: \(flight.origin) to \(to)")
            if flight.destination == to {
                itineraries.append([flight])
            }
            if let itinerary = dfs(flights: flightList, from: flight.destination, to: to) {
                itinerary.forEach {
                    let curItin = [flight] + $0
                    itineraries.append(curItin)
                }
            }
        }
    }
    return itineraries
}


// Flight("ATL", "BOS"), Flight("ATL", "YUL")
findItineraries(flights: [Flight("YUL", "BOS"), Flight("YUL", "YYZ"), Flight("YYZ", "BOS"), Flight("ATL", "BOS"), Flight("ATL", "YUL"), Flight("AUS", "ATL"), Flight("AUS", "BOS")], from: "AUS", to: "BOS")

// YUL -> BOS
// YUL -> YYZ
// YYZ -> BOS


