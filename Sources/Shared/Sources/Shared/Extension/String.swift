//
// Created by Marcelo Silva on 20/4/22.
//

import CryptoKit

public extension String {

    func md5() -> String! {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }

}