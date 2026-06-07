class TerminalAichat < Formula
  desc "A cli for AI/LLM chat in terminal. Extremely simple and easy to use. Using OpenAI-compatible `/v1/chat/completion` API"
  homepage "https://github.com/ctxinf/terminal-aichat"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.0/terminal-aichat-aarch64-apple-darwin.tar.xz"
      sha256 "935bc91117601ac9443c7785eb50c14a19b1d2eed1e8d3d69376acedcdee5445"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.0/terminal-aichat-x86_64-apple-darwin.tar.xz"
      sha256 "0d9c6400c0cd97a2ca835acb5800f3f3a4b5918ef928fd3d277afe38d0131ff8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.0/terminal-aichat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "14a5f30b99b5a7d50b02ee268a8c46848387ddc6daaa3203413b317985be95e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/terminal-aichat/releases/download/v1.1.0/terminal-aichat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c1a0973f98c7e330f9ddf065713fb1649697e2a153c60de84f02adac9819bd5"
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
