//
//  RxMVVMTests.swift
//  RxMVVMTests
//
//  Created by Dmitry Y. on 5/2/20.
//  Copyright © 2020 Dmitry Y. All rights reserved.
//

import XCTest
import Swinject
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import RxMVVM

struct JSONDataFetcher {
    
    func fetch(file: String) -> Data? {
        let bundle = Bundle(for: RxMVVMTests.self)
        
        guard let url = bundle.url(forResource: file, withExtension: "json") else {
            return nil
        }

        do {
            return try Data(contentsOf: url, options: .mappedIfSafe)
        }
        catch {
            return nil
        }
    }
    
}

class RxMVVMTests: XCTestCase {
    
    let container = Container()
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        container.register(JSONDataFetcher.self) { _ in JSONDataFetcher() }
        container.register(NetworkingInterface.self) { _ in Networking() }
            .inObjectScope(.container)
        container.register(CharactersViewModel.self) { r in
            CharactersViewModel(networkService: r.resolve(NetworkingInterface.self)!)
        }
        container.register(CharacterDetailViewModel.self) { r in
            CharacterDetailViewModel(networkService: r.resolve(NetworkingInterface.self)!)
        }
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        container.removeAll()
    }
    
    func testDecodingCharacter() throws {
        let fetcher = container.resolve(JSONDataFetcher.self)!
        
        guard let data = fetcher.fetch(file: "CharactersList") else {
            XCTFail("Error occurred parsing test data")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(GetCharactersResponse.self, from: data)
            XCTAssertEqual(object.status, "Ok")
        } catch {
            XCTFail("Error occurred parsing test data")
        }
    }
    
    func testDecodingComics() throws {
        let fetcher = container.resolve(JSONDataFetcher.self)!
        
        guard let data = fetcher.fetch(file: "ComicsList") else {
            XCTFail("Error occurred parsing test data")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(GetComicsResponse.self, from: data)
            XCTAssertEqual(object.status, "Ok")
        } catch {
            XCTFail("Error occurred parsing test data")
        }
    }
    
    func testNetworkingGetCharacters() throws {
        let networkService = container.resolve(NetworkingInterface.self)!
        let obs: Observable<GetCharactersResponse> = networkService.requestRx(CharacterRouter.getCharacters(name: "Spider-Man", limit: 1, offset: nil))
        XCTAssertEqual(try obs.toBlocking().first()?.status, "Ok")
    }
    
    func testNetworkingGetComics() throws {
        let networkService = container.resolve(NetworkingInterface.self)!
        let obs: Observable<GetComicsResponse> = networkService.requestRx(CharacterRouter.getCharacterComics(characterId: 1009157, limit: 1, offset: nil))
        XCTAssertEqual(try obs.toBlocking().first()?.status, "Ok")
    }
    
    func testCharactersViewModel() throws {
        let viewModel = container.resolve(CharactersViewModel.self)!
        let expectation = XCTestExpectation(description: "error?")
        viewModel.onBind()
        
        viewModel.error
            .drive(onNext: { _ in
                XCTFail()
                expectation.fulfill()
            }).disposed(by: disposeBag)
            
    
        scheduler.createColdObservable([.next(10, "Spider-Man")])
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)

        scheduler.start()
        
        viewModel.characters
            .filter { !$0.isEmpty}
            .drive(onNext: { value in
                print(value.count)
                XCTAssert(value.count > 0)
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCharacterDetailViewModel() throws {
        let viewModel = container.resolve(CharacterDetailViewModel.self)!
        let expectation = XCTestExpectation(description: "error?")
        viewModel.onBind()
        
        viewModel.error
            .drive(onNext: { _ in
                XCTFail()
                expectation.fulfill()
            }).disposed(by: disposeBag)
    
        scheduler.createColdObservable([.next(10, 1009351)])
            .bind(to: viewModel.characterId)
            .disposed(by: disposeBag)

        scheduler.start()
        
        viewModel.comics
            .skip(1)
            .drive(onNext: { value in
                XCTAssert(value.count > 0)
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5.0)
    }

}
