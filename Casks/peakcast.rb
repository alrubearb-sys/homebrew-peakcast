# Template of the cask in alrubearb-sys/homebrew-peakcast. The release workflow
# fills in the version and the checksum and pushes it there.
cask "peakcast" do
  version "0.4.1"
  sha256 "c2e67ece56b4f3d779a41f1978cbf0aba629ffaee0b4eb928c58579102c7f051"

  url "https://github.com/alrubearb-sys/peakcast/releases/download/v#{version}/Peakcast-#{version}-macos-arm64.zip"
  name "Peakcast"
  desc "Mountain weather in the menu bar"
  homepage "https://github.com/alrubearb-sys/peakcast"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Peakcast.app"
  binary "#{appdir}/Peakcast.app/Contents/MacOS/peakcast"

  uninstall launchctl: "local.peakcast.bar",
            quit:      "io.github.alrubearb-sys.peakcast"

  zap trash: [
    "~/.cache/peakcast",
    "~/.config/peakcast",
    "~/Library/LaunchAgents/local.peakcast.bar.plist",
  ]

  # Homebrew runs install steps where `open` cannot start an app, and a failed step
  # undoes the install, so the first start is left to the user. It writes its own
  # login item then.
  caveats "Open Peakcast once from Applications; from then on it starts at login."
end
