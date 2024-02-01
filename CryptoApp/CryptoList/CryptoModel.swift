import Foundation

struct CryptoModel: Codable, Identifiable  {
    var id: String {
        symbol
    }
    let symbol: String
    let baseAsset: String
    var openPrice: Double
    var lowPrice: Double
    var highPrice: Double
    var lastPrice: Double
    var bidPrice: Double
    var askPrice: Double
    let volume: Double
    let at: Int
    
    private enum CodingKeys: String, CodingKey {
        case symbol, baseAsset, openPrice, lowPrice, highPrice, lastPrice, bidPrice, askPrice, volume, at
    }
    
    init(symbol: String, baseAsset: String, openPrice: Double, lowPrice: Double, highPrice: Double, lastPrice: Double, bidPrice: Double, askPrice: Double, volume: Double, at: Int) {
        self.symbol = symbol
        self.baseAsset = baseAsset
        self.openPrice = openPrice
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.lastPrice = lastPrice
        self.bidPrice = bidPrice
        self.askPrice = askPrice
        self.volume = volume
        self.at = at
    }
    
    /// This init is used to initialise CryptoModel with the price fields as a Double since they were returned as a String from the API.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        baseAsset = try container.decode(String.self, forKey: .baseAsset)
        openPrice = Double(try container.decode(String.self, forKey: .openPrice)) ?? 0.0
        lowPrice = Double(try container.decode(String.self, forKey: .lowPrice)) ?? 0.0
        highPrice = Double(try container.decode(String.self, forKey: .highPrice)) ?? 0.0
        lastPrice = Double(try container.decode(String.self, forKey: .lastPrice)) ?? 0.0
        bidPrice = Double(try container.decode(String.self, forKey: .bidPrice)) ?? 0.0
        askPrice = Double(try container.decode(String.self, forKey: .askPrice)) ?? 0.0
        volume = Double(try container.decode(String.self, forKey: .volume)) ?? 0.0
        at = try container.decode(Int.self, forKey: .at)
    }
    
}
