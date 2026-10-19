class Netinspect < Formula
  desc "Monitor network connections of Linux processes"
  homepage "https://github.com/ctxinf/netinspect"
  version "0.1.5"
  license "MIT"

  depends_on :linux

  on_intel do
    depends_on arch: :x86_64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.5/netinspect_linux_amd64_glibc.tar.gz"
    sha256 "4f84685946df5de08d33c0181fc9919a2d7d615b679f4c88ac5d8b91532d44ab"
  end
  on_arm do
    depends_on arch: :arm64
    url "https://github.com/ctxinf/netinspect/releases/download/v0.1.5/netinspect_linux_arm64_glibc.tar.gz"
    sha256 "5664e3b01c8263ee53c176ac4219719b4986b03fbb01f2aa552ebaae3237f488"
  end

  def install
    bin.install "netinspect"
  end

  test do
    assert_equal "netinspect v0.1.5", shell_output("#{bin}/netinspect --version").strip
  end
end
