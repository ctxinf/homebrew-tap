class AtuinWebManage < Formula
  desc "Local web UI to manage (search, edit, bulk-delete) atuin shell history"
  homepage "https://github.com/ctxinf/atuin-web-manage"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.4/atuin-web-manage-aarch64-apple-darwin.tar.xz"
      sha256 "481b873b68a003b695f1e5f491badefdad40e3a77a3b87d282aea85420c631fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.4/atuin-web-manage-x86_64-apple-darwin.tar.xz"
      sha256 "46a8ab9b409dd782c7c1872b191aca11e4e719df0d4cd373d789008364e032df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.4/atuin-web-manage-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69301a8449d73a7ab0e743611fd514cfa4bd03c0b30979a3b7271b1fe0bfe799"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.4/atuin-web-manage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0bf840c3310733a365eb04a5795f8808923fe315f3f7a3998ebbaade0c81a22b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
    bin.install "atuin-web-manage" if OS.mac? && Hardware::CPU.arm?
    bin.install "atuin-web-manage" if OS.mac? && Hardware::CPU.intel?
    bin.install "atuin-web-manage" if OS.linux? && Hardware::CPU.arm?
    bin.install "atuin-web-manage" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
