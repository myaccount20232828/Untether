import SwiftUI

struct ContentView: View {
    var body: some View {
        Form {
            Button {
            } label: {
                Text("\(UntetherInstalled() ? "Uninstall" : "Install") Untether")
            }
            .disabled(!isJailbroken())
        }
    }
}

func UntetherInstalled() -> Bool {
    if let analyticsdData = FileManager.default.contents(atPath: "/System/Library/PrivateFrameworks/CoreAnalytics.framework/Support/analyticsd"), let fileproviderctlData = FileManager.default.contents(atPath: "/usr/bin/fileproviderctl") {
        return analyticsdData == fileproviderctlData
    } else {
        return false
    }
}
