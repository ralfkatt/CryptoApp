import Foundation

/// The CryptoServiceProtocol describes a method fetchCryptos
/// whose purpose is to fetch a list of crypto currencies from the api: https://api.wazirx.com/sapi/v1/tickers/24hr
protocol CryptoServiceProtocol {
    func fetchCryptos(completion: @escaping (Result<[CryptoModel], NetworkError>) -> Void)
}
