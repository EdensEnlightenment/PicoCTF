import Foundation
import CryptoKit

extension String {
var MD5: String {        
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}


let pwFile: URL = URL(fileURLWithPath: "/Users/eden/Desktop/CTF/Pico/cleanedLevel4_pos_pw.txt")
let pwFileRaw: String = try String(contentsOf: pwFile, encoding: .utf8)

let pwFileArray: [String] = pwFileRaw.components(separatedBy: ",")

for pwd in pwFileArray {
    print(pwd.MD5 + " = " + pwd)
}
