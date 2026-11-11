class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "2.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.2/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "1f67bccb9c7b1ee4787f9d4bcbac5a3e42705ef0fff62d8d2c8160236bd00980"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.2/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "a09a158064c8f68f1d724eecc04087f4025ceedc202ee814297a5b69657bd50e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.2/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4736e97985ff9d485eb3312258a877a8fc53a373ac2141fa59575051d681502"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.2/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "489ffd6376481310d311e5d715b8db71015b804d3d5c2cbf17c1119ec0d50517"
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
