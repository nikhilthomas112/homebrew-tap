# Homebrew cask for Mesh, for the tap nikhilthomas112/homebrew-tap.
# Users install with:  brew install --cask nikhilthomas112/tap/mesh
# scripts/stage-site-release.py fills in version and sha256 for each release.
cask "mesh" do
  version "0.1.0-beta"
  sha256 "187aca53aeba74b457e24e0e007f77a4d5f5c61e8c530e89e1f769ce77249fe9"

  url "https://qwintlabs.com/downloads/mesh/Mesh-#{version}-mac-intel.dmg"
  name "Mesh"
  desc "Use your computers and Android phone as one device"
  homepage "https://qwintlabs.com/mesh"

  depends_on macos: ">= :big_sur"

  app "Mesh.app"

  # Mesh is not notarized (that needs a paid Apple Developer account), so
  # macOS would refuse to open it from a quarantined download. Installing
  # through Homebrew is the user's choice to trust it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Mesh.app"],
                   sudo: false
  end

  uninstall quit: "app.mesh.desktop"

  zap trash: [
    "~/Library/Application Support/app.mesh.desktop",
    "~/Library/Caches/app.mesh.desktop",
    "~/Library/Logs/app.mesh.desktop",
    "~/Library/Preferences/app.mesh.desktop.plist",
    "~/Library/WebKit/app.mesh.desktop",
  ]

  caveats <<~EOS
    Mesh asks for Accessibility (to share the mouse and keyboard) and
    Notifications the first time you use those features.
  EOS
end
