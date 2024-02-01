import Combine
import Foundation
import XCTest

class WalletViewModelTests: XCTestCase {
    var walletViewModel: WalletViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        self.walletViewModel = WalletViewModel()
    }
    
    func testBuyCrypto() {
        let expectation = XCTestExpectation(description: "Published property should update")

        let crypto = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 50600.0,
            volume: 1000.0,
            at: 1234567890
        )
        
        // Subcribe to changes in cryptos
        walletViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                XCTAssertFalse(cryptos.isEmpty, "Cryptos should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        walletViewModel.buyCrypto(crypto: crypto)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testBuyCryptoSameAssetTwice() {
        let expectation = XCTestExpectation(description: "Published property should update")

        let crypto = CryptoModel(
            symbol: "BTC",
            baseAsset: "Bitcoin",
            openPrice: 50000.0,
            lowPrice: 49000.0,
            highPrice: 51000.0,
            lastPrice: 50500.0,
            bidPrice: 50400.0,
            askPrice: 50600.0,
            volume: 1000.0,
            at: 1234567890
        )
        
        var updateCount = 0
        
        // Subcribe to changes in cryptos
        walletViewModel.$cryptos
            .dropFirst()
            .sink { cryptos in
                // In order to check the last update we skip the first one
                updateCount += 1
                if(updateCount < 2) {
                    return
                }
                XCTAssertFalse(cryptos.isEmpty, "Cryptos should not be empty")
                XCTAssertEqual(cryptos.count, 2)

                expectation.fulfill()
            }
            .store(in: &cancellables)
        walletViewModel.buyCrypto(crypto: crypto)
        walletViewModel.buyCrypto(crypto: crypto)

        wait(for: [expectation], timeout: 5.0)
    }
}
