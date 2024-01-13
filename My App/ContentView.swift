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
                    spawnRoot(Bundle.main.executablePath ?? "", ["uninstall"])
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
