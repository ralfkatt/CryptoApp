import Foundation

class CryptoService: CryptoServiceProtocol {
    let cryptoUrl = "https://api.wazirx.com/sapi/v1/tickers/24hr"
    func fetchCryptos(completion: @escaping (Result<[CryptoModel], NetworkError>) -> Void) {
        guard let url = URL(string: cryptoUrl) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            do {
                let cryptos = try JSONDecoder().decode([CryptoModel].self, from: data)
                completion(.success(cryptos))
            }
            catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
