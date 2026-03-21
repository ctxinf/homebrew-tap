class GumRs < Formula
  desc "Super fast git multiple user config manager. A Rust remake of https://github.com/gauseen/gum"
  homepage "https://github.com/ctxinf/gum-rs"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/gum-rs/releases/download/v0.0.7/gum-rs-aarch64-apple-darwin.tar.xz"
      sha256 "e68dbe267a8c6cfb1116c084a283681a25c3d1fec76e04e18bb434c4c2343e39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/gum-rs/releases/download/v0.0.7/gum-rs-x86_64-apple-darwin.tar.xz"
      sha256 "0b189186e75aeeae7d3ba2082665aa32b33af3656c748f4325d7e72854ff044f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/gum-rs/releases/download/v0.0.7/gum-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f601f5c7c75e50a4996b629a20faf3e103718ae56ca43b0a599681a47dcfca8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/gum-rs/releases/download/v0.0.7/gum-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2c53c01da036cc89fdb2b77f352a6884f328f5cedddcdcb7114115a59c7e9957"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "gum" if OS.mac? && Hardware::CPU.arm?
    bin.install "gum" if OS.mac? && Hardware::CPU.intel?
    bin.install "gum" if OS.linux? && Hardware::CPU.arm?
    bin.install "gum" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
