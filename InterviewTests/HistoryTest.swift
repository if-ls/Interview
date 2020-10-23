//
//  HistoryTest.swift
//  InterviewTests
//
//  Created by Wang on 2020/10/22.
//  Copyright © 2020 if-ls. All rights reserved.
//

import XCTest
@testable import Interview

class HistoryTest: XCTestCase {
    
    var vc = HomeViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        var resp: Data?
        let ex = expectation(description: "请求超时")
        
        vc.apiGet { (data) in
            resp = data
            ex.fulfill()
            XCTAssertNotNil(data, "请求失败")
        }
        
        waitForExpectations(timeout: 5) { (err) in
            let ret = History.get()
            XCTAssertNotNil(ret, "History查询失败")
            XCTAssertEqual(resp, ret?.resp, "数据不一致")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
