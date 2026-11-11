class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "2.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.1/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "c277fc3235574089fd4e55949f16827b02a8350a834af4fcfd11a9479b9eae71"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.1/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "17214ebf9cd29c9c95c42dbb4e89bff39998a6f3d4a56905595b5b281d9a2e6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.1/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d37a04cb93ac6b138f92d8f73ec55c0e2bd3fe0b649b10a2318552c0c6c6c9ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.1/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "28f57f1220f1235c21c4a6277b18e55461a680dd6617d8f2edf1831967f7957e"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "aichat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "aichat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "aichat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "aichat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
