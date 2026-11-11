class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "2.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.2.1/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "9ca80571df8ceb560b7511cd836ed7a643ecf45aa57a84acc67a4a33fe95cccd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.2.1/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "ce8a8f7a7454c602c3e9a5b1ca4b3b697a359f19e60e4368634b5f2448be6772"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.2.1/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ba8048d524770efcead6ba921479e3a970d319c98a73bf1fcb04ca88df3fda15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.2.1/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05fdf914fef4778309d883a2e633eb93e94e2cb0550563b25001c948ab8324a5"
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
