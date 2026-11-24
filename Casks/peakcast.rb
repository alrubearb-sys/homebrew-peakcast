# Template of the cask in alrubearb-sys/homebrew-peakcast. The release workflow
# fills in the version and the checksum and pushes it there.
cask "peakcast" do
  version "0.4.4"
  sha256 "19893a08e6fa3d495a8fa213c06155d1096a9a4552e9f2b9b88c37960c7bb5ce"

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
