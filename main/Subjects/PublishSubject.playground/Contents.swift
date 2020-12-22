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
 # PublishSubject
 */

let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<String>()

subject.onNext("Hello")


let o1 = subject.subscribe { print(">> 1",$0)} //구독이후에 전달되는 이벤트만 전달 (위에 hello x)
o1.disposed(by: disposeBag)

subject.onNext("RxSwift") // rxswift를 다음 다음 next이벤트가 subject로 이동되고 subject는 이이벤트를 구독자에게 전달 o1
let o2 = subject.subscribe{print(">> 2",$0)}
o2.disposed(by: disposeBag)

subject.onNext("subJect") //이하동문

//subject.onCompleted()
subject.onError(MyError.error) //에러는 구독자 전체로 전달  Publish>포함 So,(PUblishSubject는 이벤트가 전달되면 즉시 구독자에게 전달 >> subject최초로 생성되는 시점과 최초로 구독되는 시점 사이에 전달되는 이벤트는 그냥 사라짐 >>이게문제가된다면 replay나 cold 사용 )

let o3 = subject.subscribe{print(">> 3",$0)}
o3.disposed(by: disposeBag) //comleted있으면 그거수행 넥스트이벤트가 차피 없어서 !



