class Deviceaudiosr < Formula
  desc "Inspect and set CoreAudio device sample rates"
  homepage "https://github.com/4L3X4NND3RR/DeviceAudioSR"
  url "https://github.com/4L3X4NND3RR/DeviceAudioSR/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "5cdbc62363cdac7293ba82b5efb738273a932b501f0db34162d10fe02d3ab679"
  license "MIT"
  head "https://github.com/4L3X4NND3RR/DeviceAudioSR.git", branch: "main"

  # Package.swift requires macOS 15.6. Homebrew can only declare Sequoia (15).
  depends_on macos: :sequoia
  depends_on xcode: ["16.0", :build]

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
