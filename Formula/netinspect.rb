class Netinspect < Formula
  desc "Monitor network connections of Linux processes"
  homepage "https://github.com/ctxinf/netinspect"
  url "https://github.com/ctxinf/netinspect/releases/download/v0.1.1/netinspect_linux_amd64.tar.gz"
  version "0.1.1"
  sha256 "17603d0ca241a55d95bb668d70c40bc8f9c9c3742172c086445de7c18d2a97e9"
  license "MIT"

  depends_on :linux
  depends_on arch: :x86_64

  def install
    bin.install "netinspect"
  end

  test do
    assert_equal "netinspect v0.1.1", shell_output("#{bin}/netinspect --version").strip
  end
end
