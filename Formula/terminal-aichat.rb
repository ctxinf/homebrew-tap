class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "1.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.1/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "2c9ea3d2aea47f36bc53cc5f6891f6c48c8abfcf3aba4043254d2bac37bb2be9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.1/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "83a747f33db66b9e24b1dce0c1d7113d5091eff19c27ffbfbef52273ff29b20c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.1/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e00c5a56b0e7121d0d5431d50beac40db6c5def7b80ee311febdff4d7306f6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.1/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5ff9adb73fd64f8e48d66b0ba771628bcbd6bc8438ef24dc5f6f8345254a6bd"
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
    bin.install "aichat" if OS.mac? && Hardware::CPU.arm?
    bin.install "aichat" if OS.mac? && Hardware::CPU.intel?
    bin.install "aichat" if OS.linux? && Hardware::CPU.arm?
    bin.install "aichat" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
