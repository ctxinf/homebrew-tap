class AgentEnvGuard < Formula
  desc "Run commands while masking configured environment secret values from stdout and stderr."
  homepage "https://github.com/ctxinf/agent-env-guard"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.5/agent-env-guard-aarch64-apple-darwin.tar.xz"
      sha256 "aa53b532b5e4d794c77f2c1c3532fc019d858be7453e97a7aafa20cd52323b57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.5/agent-env-guard-x86_64-apple-darwin.tar.xz"
      sha256 "5d479e7327acc8a45ef08ad97b7d20a285dcca41a44347eb1da6dcc3235c94fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.5/agent-env-guard-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f1c70a1cf66b0f6c4b140b03a6984b9d9a784da855676c8470f07cf34caee3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctxinf/agent-env-guard/releases/download/v0.1.5/agent-env-guard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cfb1c09bf54f730a334c1a21fc55a8f0eb3bed09c74c25d8fa30a9b1777cd8b2"
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
    bin.install "maskrun" if OS.mac? && Hardware::CPU.arm?
    bin.install "maskrun" if OS.mac? && Hardware::CPU.intel?
    bin.install "maskrun" if OS.linux? && Hardware::CPU.arm?
    bin.install "maskrun" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
