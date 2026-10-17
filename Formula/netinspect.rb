class Netinspect < Formula
  desc "Monitor network connections of Linux processes"
  homepage "https://github.com/ctxinf/netinspect"
  url "https://github.com/ctxinf/netinspect/releases/download/v0.1.2/netinspect_linux_amd64.tar.gz"
  version "0.1.2"
  sha256 "1947407ca6dc154849515d9a657982cd96bc613f8d10eb8a9f2956785d3974a0"
  license "MIT"

  depends_on :linux
  depends_on arch: :x86_64

  def install
    bin.install "netinspect"
  end

  test do
    assert_equal "netinspect v0.1.2", shell_output("#{bin}/netinspect --version").strip
  end
end
