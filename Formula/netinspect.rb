class Netinspect < Formula
  desc "Monitor network connections of Linux processes"
  homepage "https://github.com/ctxinf/netinspect"
  version "0.1.4"
  license "MIT"

  depends_on :linux

  on_intel do
    depends_on arch: :x86_64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.4/netinspect_linux_amd64_glibc.tar.gz"
    sha256 "f52483459cde06cf793bd3add2d04f1b1458584ba265ed3fe9071cdecc12c8c5"
  end
  on_arm do
    depends_on arch: :arm64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.4/netinspect_linux_arm64_glibc.tar.gz"
    sha256 "e507645ffc9c44157fa6a514741c03eb91ca1f0dcad2d4595cab530c12e379b3"
  end

  def install
    bin.install "netinspect"
  end

  test do
    assert_equal "netinspect v0.1.4", shell_output("#{bin}/netinspect --version").strip
  end
end
