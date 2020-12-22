//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # combineLatest
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()
//ab 있으면 서로 가장 최근것들끼리 결합해서 방출, 그중에하나 업데이트 되면 최근걸로 또 바꿔서 방출
Observable.combineLatest(greetings,languages) {
    lhs,rhs -> String in
    return "\(lhs)\(rhs)"
}
.subscribe{ print($0) }
.disposed(by: bag)

greetings.onNext("hi")
languages.onNext("d")

greetings.onNext("Hello")
languages.onNext("RXswift")

//greetings.onCompleted() //한쪽 종료
greetings.onError(MyError.error) //둘중에 하나라도 에러 발생하면 에러이벤트만 전달! 
languages.onNext("SWIFTUI")

languages.onCompleted() //양쪽다하면 구독자에게 컴플리티드 전달



