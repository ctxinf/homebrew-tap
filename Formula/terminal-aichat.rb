class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "2.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.0/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "d2eb0bfc820769b07a85090be85fdde80a9ce2467c68746a0ea0663d97e985c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.0/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "6c0bf8a10b03b82159180902fb156c22eb92483864b044e2ae0d9ae8e41dcade"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.0/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0008765c36d617984e90d8dee60803da14178dd50fe19696cf3204d6fb1b39b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v2.3.0/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8871021b7b43ff07025252549699af7f868b41714b21133b5274086b41431b52"
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
