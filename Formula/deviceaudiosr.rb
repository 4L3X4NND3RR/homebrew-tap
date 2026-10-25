class Deviceaudiosr < Formula
  desc "Inspect and set CoreAudio device sample rates"
  homepage "https://github.com/4L3X4NND3RR/DeviceAudioSR"
  url "https://github.com/4L3X4NND3RR/DeviceAudioSR/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "4a6b8b7570565bbf2552da63e6addcc5d48b4e804165829af8af17ef6ac64fe1"
  license "MIT"
  head "https://github.com/4L3X4NND3RR/DeviceAudioSR.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  # Package.swift requires macOS 15.6. Homebrew can only declare Sequoia (15).
  depends_on macos: :sequoia

  def install
    # SwiftPM's sandbox cannot nest inside Homebrew's; Homebrew still sandboxes the build.
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/deviceaudiosr"
  end

  def caveats
    "Requires macOS 15.6 or newer. Sequoia is the oldest OS Homebrew can declare."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/deviceaudiosr --version")
  end
end
