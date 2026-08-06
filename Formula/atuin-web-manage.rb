class AtuinWebManage < Formula
  desc "Local web UI to manage (search, edit, bulk-delete) atuin shell history"
  homepage "https://github.com/ctxinf/atuin-web-manage"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.3/atuin-web-manage-aarch64-apple-darwin.tar.xz"
      sha256 "41c7f69c988274c5038973a92e83376f31cbea824671aad7ef90813ffed2d40b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.3/atuin-web-manage-x86_64-apple-darwin.tar.xz"
      sha256 "dfd864d50f65466578ecefab36f0639cc07aaf80d66b775ebcdca4071b678158"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.3/atuin-web-manage-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6b8bfbf69b76ae01a81e5ce59566fff7b2ead24b94d06de8c4ea918e0130c19c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/atuin-web-manage/releases/download/1.0.3/atuin-web-manage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "67391d1020cbcf2845eded0c976e2cc2d8ad8a9c3c38cb083b6b66756469348c"
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
