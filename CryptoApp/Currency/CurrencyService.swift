import Foundation

class CurrencyService: CurrencyServiceProtocol {
    let currencyUrl = "https://open.er-api.com/v6/latest/USD"
    func fetchCurrencyExchangeRate(completion: @escaping (Result<Double, NetworkError>) -> Void) {
        guard let url = URL(string: currencyUrl) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            do {
                let cryptos = try JSONDecoder().decode(ExchangeRateModel.self, from: data)
                
                /// Return only for SEK for this MVP
                if let sekRate = cryptos.rates["SEK"] {
                    completion(.success(sekRate))
                }
                else {
                    completion(.failure(.noData))
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
