import SwiftUI

struct ContentView: View {
    @State var Log = ""
    var body: some View {
        Form {
            if !Log.isEmpty {
                Section {
                    Text(Log)
                }
            }
            Button {
                if UntetherInstalled() {
                    let Output = String(describing: spawnRoot(Bundle.main.executablePath ?? "", ["uninstall"]).dropLast())
                    if !Output.isEmpty {
                        Log = Output
                    }
                } else {
                    Log = spawnRoot(Bundle.main.executablePath ?? "", ["install"])
                }
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
