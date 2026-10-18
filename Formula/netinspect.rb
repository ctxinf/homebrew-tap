class Netinspect < Formula
  desc "Monitor network connections of Linux processes"
  homepage "https://github.com/ctxinf/netinspect"
  version "0.1.3"
  license "MIT"

  depends_on :linux

  on_intel do
    depends_on arch: :x86_64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.3/netinspect_linux_amd64_glibc.tar.gz"
    sha256 "e3107d2a35155d106031bb5854c65180bd67a02ed2e0e9f25d2fef9b907f745d"
  end
  on_arm do
    depends_on arch: :arm64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.3/netinspect_linux_arm64_glibc.tar.gz"
    sha256 "fc94a7113d4dd6d0c3740d664a9883ec896b63187f0b4d73c93125bffd504e4e"
  end

  def install
    bin.install "netinspect"
  end

  test do
    assert_equal "netinspect v0.1.3", shell_output("#{bin}/netinspect --version").strip
  end
end
