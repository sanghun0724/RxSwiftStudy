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
 # flatMap
 */

let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap{ $0.asObservable() } //받아서 새로운거 생성! 이경우엔 섭젝트 받아서 옵저버블 방출
    .subscribe{print($0)}
    .disposed(by: disposeBag)

subject.onNext(a)
subject.onNext(b) //모든 옵저버블은 하나의 옵저버블로 최종적으로 모두 합쳐지고 (flatmap) 방출되는 항목들이 순차적으로 구독자에게 전달됩니다.

a.onNext(11)
b.onNext(22)
 // 새로운 옵저버블은 항목이 업데이트 될때마다 새로운 하나 옵저버블을 갱신 > 구독자 전달
